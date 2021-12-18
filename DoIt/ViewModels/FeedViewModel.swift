//
//  FeedViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 17.12.2021.
//

import Foundation
import FirebaseAuth

final class FeedViewModel {
    private let userService = UserService.shared
    private let taskService = TaskService.shared
    
    var userModel: Observable<UserModel> = Observable()
    
    var userFollowing: Observable<[UserModel]> = Observable()
    
    var userFollowingTasks: Observable<[Task]> = Observable()
    
    func getCurrentUser() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let uid = Auth.auth().currentUser?.uid, self?.userModel.value == nil else {
                return
            }
            self?.userService.fetchUser(uid: uid) { [weak self] user in
                self?.userModel.value = user
            }
        }
    }
    
    func getFollowing() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let uid = Auth.auth().currentUser?.uid, self?.userModel.value?.uid == uid else {
                return
            }
            self?.userService.fetchUserFollowing(uid: uid, completion: { uids in
                var followings: [UserModel] = []
                uids.forEach { uid in
                    self?.userService.fetchUser(uid: uid, completion: { [weak self] in
                        followings.append($0)
                        if uids.last == uid {
                            self?.userFollowing.value = followings
                        }
                    })
                }
            })
        }
    }
    
    func getFollowingTasks() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let uid = Auth.auth().currentUser?.uid, self?.userModel.value?.uid == uid else {
                return
            }
            guard let users = self?.userFollowing.value else { return }
            var allTasks: [Task] = []
            users.forEach({ [weak self] user in
                self?.taskService.fetchTasks(forUser: user, completion: { [weak self] tasks in
                    guard let task = tasks.last else { return }
                    allTasks.append(task)
                    if users.last?.uid == user.uid {
                        self?.userFollowingTasks.value = allTasks
                    }
                })
            })
        }
    }
    
    func downloadImage(_ url: URL?, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            ImageLoader.downloadImage(url: url, complition: { image in
                DispatchQueue.main.async {
                    completion(image)
                }
            })
        }
    }
}
