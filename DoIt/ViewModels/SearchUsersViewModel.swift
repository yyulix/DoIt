//
//  SearchUsersViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 14.12.2021.
//

import Foundation
import Firebase

final class SearchUsersViewModel {
    private let userService = UserService.shared
    
    var userModel: Observable<UserModel> = Observable()
    
    var userModels: Observable<[UserModel]> = Observable([])
    
    var filteredUsersModel: Observable<[UserModel]> = Observable()
    
    func getCurrentUser() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            self?.userService.fetchUser(uid: uid) { [weak self] user in
                self?.userModel.value = user
            }
        }
    }
    
    func getAllUsers() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.userService.fetchUsers(completion: { [weak self] users in
                guard let user = self?.userModel.value else { return }
                let users = users.filter({ $0.uid != user.uid })
                users.forEach { user in
                    self?.userService.isUserFollowed(uid: user.uid) { [weak self] in
                        user.isFollowed = $0
                        if let currentUser = users.last, currentUser.uid == user.uid {
                            self?.userModels.value = users
                        }
                    }
                }
            })
        }
    }
    
    func updateFollowing() {
        guard let users = userModels.value else { return }
        DispatchQueue.global().async { [weak self] in
            users.forEach { user in
                self?.userService.isUserFollowed(uid: user.uid) {
                    user.isFollowed = $0
                }
            }
        }
    }
    
    func followUser(_ user: UserModel, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            self?.userService.followUser(uid: user.uid) { error, _ in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                user.isFollowed = true
                completion(true)
            }
        }
    }
    
    func unfollowUser(_ user: UserModel, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            self?.userService.unfollowUser(uid: user.uid) { error, _ in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                user.isFollowed = false
                completion(true)
            }
        }
    }
    
    func downloadImage(_ url: URL?, completion: @escaping (UIImage?) -> ()) {
        ImageLoader.downloadImage(url: url, complition: { image in
            DispatchQueue.main.async {
                completion(image)
            }
        })
    }
    
    func filtering(username: String) {
        DispatchQueue.global().async { [weak self] in
            self?.filteredUsersModel.value = self?.userModels.value?.filter { $0.username.lowercased().contains(username.lowercased()) }
        }
    }
    
    func stopFiltering() {
        filteredUsersModel.value = nil
    }
}

