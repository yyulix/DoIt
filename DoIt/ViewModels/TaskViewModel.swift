//
//  TaskViewModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 16.12.2021.
//

import Foundation
import UIKit

final class TaskViewModel {
    private let taskService = TaskService.shared
    
    var taskModel: Observable<Task> = Observable()
    
    func getTask() {
        guard let taskModel = taskModel.value else { return }
        DispatchQueue.global().async { [weak self] in
            self?.taskService.fetchTask(taskId: taskModel.taskId, completion: { [weak self] task in
                self?.taskModel.value = task
            })
        }
    }
    
    func createTask(image: UIImage?, title: String, description: String?, deadline: Date?, uid: String, color: UIColor, complition: @escaping () -> ()) {
        DispatchQueue.global().sync {
            if title.isEmpty {
                Logger.log("Пустое название")
                return
            }
            let values = [
                          "title": title,
                          "description": description ?? "",
                          "deadline": Int(deadline?.timeIntervalSince1970 ?? 0),
                          "is_done": false,
                          "uid": uid,
                          "color": UIColor().HexFromColor(color: color)
            ] as [String : Any]
            
            taskService.uploadTask(task: Task(id: "", dictionary: values as [String: AnyObject])) { [weak self] error, taskId in
                if let error = error {
                    Logger.log("Ошибка загрузки задачи \(error)")
                    return
                }
                guard let image = image else {
                    Logger.log("Задача без фото загружена")
                    complition()
                    return
                }
                self?.taskService.updateTaskImage(taskId: taskId, image: image, completion: { [weak self] url in
                    guard url != nil else {
                        Logger.log("Ошибка загрузки изображения задачи")
                        return
                    }
                    self?.taskService.fetchTask(taskId: taskId, completion: { [weak self] task in
                        self?.taskModel.value = task
                        complition()
                    })
                })
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
}
