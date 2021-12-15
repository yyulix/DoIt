//
//  SearchUsersViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 14.12.2021.
//

import Foundation
import Firebase

final class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    private var listener: ((T?) -> ())?
    
    func bind(_ listener: @escaping (T?) -> ()) {
        listener(value)
        self.listener = listener
    }
}

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
                users.forEach { user in
                    self?.userService.isUserFollowed(uid: user.uid) { user.isFollowed = $0 }
                }
                self?.userModels.value = users
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
                user.isFollowed = true
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
                user.isFollowed = true
                completion(true)
            }
        }
    }
    
    func downloadImage(_ url: URL?, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            var cellImage: UIImage? = nil
            guard let url = url else {
                completion(cellImage)
                return
            }
            if let data = try? Data(contentsOf: url) {
                cellImage = UIImage(data: data)
            }
            completion(cellImage)
        }
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

