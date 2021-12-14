//
//  ProfileViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 14.12.2021.
//

import Foundation

final class ProfileViewModel {
    private let userService = UserService.shared
    private let taskService = TaskService.shared
    
    var userModel: Observable<UserModel> = Observable()
    
    var userFollowingModel: Observable<UserFollowingModel> = Observable()
    
    var userTasksModel: Observable<UserTasksModel> = Observable()
    
    func getUserTasks() {
        DispatchQueue.global().async { [weak self] in
            guard let user = self?.userModel.value else {
                
                return
            }
            self?.taskService.fetchTasks(forUser: user, completion: { [weak self] tasks in
                self?.userTasksModel.value = UserTasksModel(login: user.username, tasks: tasks)
            })
        }
    }
    
    func getUserFollowings() {
        DispatchQueue.global().async { [weak self] in
            guard let user = self?.userModel.value else {
                
                return
            }
            self?.userService.fetchUserFollowing(uid: user.uid, completion: { uids in
                var followings: [UserModel] = []
                uids.forEach { uid in
                    self?.userService.fetchUser(uid: uid, completion: { followings.append($0) })
                }
                self?.userFollowingModel.value = UserFollowingModel(login: user.username, followings: followings)
            })
        }
    }
    
    func followUser(_ user: UserModel, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            self?.userService.followUser(uid: user.uid) { error, _ in
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(false)
                    return
                }
                self?.userModel.value?.isFollowed = true
                completion(true)
            }
        }
    }
    
    func unfollowUser(_ user: UserModel, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            self?.userService.unfollowUser(uid: user.uid) { error, _ in
                guard error == nil else {
                    print(error!.localizedDescription)
                    completion(false)
                    return
                }
                self?.userModel.value?.isFollowed = true
                completion(true)
            }
        }
    }
}
