//
//  TasksViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 14.12.2021.
//

import Foundation
import UIKit

final class TasksViewModel {
    private let taskService = TaskService.shared
    
    var taskModels: Observable<[Task]> = Observable([])
    
    var taskModel: Observable<Task> = Observable()
    
    func getTasks(forUser:  UserModel) {
        self.taskService.fetchTasks(forUser: forUser) { [weak self] tasks in
            self?.taskModels.value = tasks
        }
    }
    
    func getTask(withId: String) {
        self.taskService.fetchTask(taskId: withId) { [weak self] task in
            self?.taskModel.value = task
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
