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
                return
            }
            var wasChanged = false
            
            var newImage = userModel.image
            if let image = image, image != newImage {
                newImage = image
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
                return
            }
            
            let newUserModel = UserModel(uid: userModel.uid, email: userModel.email, username: username, summary: newSummary, image: newImage, name: newName)
            
            self?.userService.updateUserData(user: newUserModel, completion: { error, _ in
                if error != nil {
                    
                }
                complition()
            })
        }
    }
}
