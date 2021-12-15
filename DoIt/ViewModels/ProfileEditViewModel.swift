//
//  ProfileEditViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 14.12.2021.
//

import Foundation
import UIKit

final class ProfileEditViewModel {
    private let userService = UserService.shared
    var userModel: Observable<UserModel> = Observable()
    
    func updateUserProfile(image: UIImage?, name: String?, username: String, summary: String?, complition: @escaping () -> ()) {
        DispatchQueue.global().sync { [weak self] in
            guard let userModel = userModel.value else {
                complition()
                return
            }
            var wasChanged = false
            
            var newImageURL: URL? = nil
            if let image = image {
                userService.updateUserPhoto(image: image) { url in
                    newImageURL = url
                }
                guard newImageURL != nil else {
                    complition()
                    return
                }
                wasChanged = true
            }
            
            var newName = userModel.name
            if let name = name, name != newName {
                newName = name
                wasChanged = true
            }
            
            var newSummary = userModel.summary
            if let summary = summary, summary != newSummary {
                newSummary = summary
            }
            
            if username != userModel.username {
                wasChanged = true
            }
            
            guard wasChanged else {
                complition()
                return
            }
            
            let newUserModel = UserModel(uid: userModel.uid, email: userModel.email, username: username, summary: newSummary, imageURL: newImageURL, name: newName)
            
            self?.userService.updateUserData(user: newUserModel, completion: { error, _ in
                if error != nil {
                    
                }
                complition()
            })
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
}
