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
    
    func updateUserProfile(image: UIImage?, name: String?, username: String?, summary: String?, complition: @escaping () -> (), complitionError: @escaping (String) -> ()) {
        DispatchQueue.global().sync { [weak self] in
            guard let userModel = userModel.value else {
                Logger.log("Пользователь не найден")
                return
            }
            
            var wasChanged = false
            
            wasChanged = image != nil
            
            var newName = userModel.name
            if let name = name?.trimmingCharacters(in: .whitespacesAndNewlines), name != newName {
                newName = name
                wasChanged = true
            }
            
            var newSummary = userModel.summary
            if let summary = summary?.trimmingCharacters(in: .whitespacesAndNewlines), summary != newSummary {
                newSummary = summary
                wasChanged = true
            }
            
            var newUsername = userModel.username
            if let username = username?.trimmingCharacters(in: .whitespacesAndNewlines), username != newUsername, !username.isEmpty {
                newUsername = username
                wasChanged = true
            }
            
            guard wasChanged else {
                Logger.log("Ничего не поменялось")
                return
            }
            
            var values: [String: String] = ["email": userModel.email, "username": newUsername, "summary": newSummary ?? "", "name": newName ?? ""]
            
            if let image = image {
                self?.userService.updateUserPhoto(image: image) { [weak self] url in
                    guard url != nil else {
                        Logger.log("Ошибка обновления изображения")
                        complitionError(ErrorStrings.image.rawValue.localized)
                        return
                    }
                    values["userPhotoUrl"] = url?.absoluteString ?? ""
                    self?.userModel.value = UserModel(uid: userModel.uid, dictionary: values as [String: AnyObject])
                    self?.updateUser(complition: complition, complitionError: complitionError)
                }
            } else {
                self?.userModel.value = UserModel(uid: userModel.uid, dictionary: values as [String: AnyObject])
                self?.updateUser(complition: complition, complitionError: complitionError)
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
    
    func updateUser(complition: @escaping () -> (), complitionError: @escaping (String) -> ()) {
        guard let userModel = userModel.value else { return }
        userService.updateUserData(user: userModel, completion: { error, _ in
            if let error = error {
                Logger.log("Ошибка обращения к бд \(error)")
                complitionError(ErrorStrings.database.rawValue.localized)
                return
            }
            Logger.log("Профиль обновлен")
            complition()
        })
    }
}
