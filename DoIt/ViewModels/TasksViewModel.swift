//
//  TasksViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 14.12.2021.
//

import Foundation
import UIKit
import FirebaseAuth

final class TasksViewModel {
    private let userService = UserService.shared
    private let taskService = TaskService.shared
    
    private var previousSelectedChapterId = -1
    
    let chapters = (0...(TaskCategory.chaptersCount - 1)).map({ TaskCategory(index: $0) })
    
    var userModel: Observable<UserModel> = Observable()
    
    var taskModels: Observable<[Task]> = Observable()
    
    var selectedTaskModels: Observable<[Task]> = Observable()
    
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
    
    func getTasks() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let userModel = self?.userModel.value else { return }
            self?.taskService.fetchTasks(forUser: userModel) { [weak self] tasks in
                self?.taskModels.value = tasks
            }
        }
    }
    
    func filterTasks(row: Int) {
        let newSelectedTasks = taskModels.value?.filter({ $0.chapterId == row })
        guard previousSelectedChapterId != row else {
            previousSelectedChapterId = -1
            selectedTaskModels.value = nil
            return
        }
        selectedTaskModels.value = newSelectedTasks
        previousSelectedChapterId = row
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
