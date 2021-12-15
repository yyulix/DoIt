//
//  TasksViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 14.12.2021.
//

import Foundation

final class TasksViewModel {
    private let taskService = TaskService.shared
    
    var taskModels: Observable<[Task]> = Observable([])
    
    var taskModel: Observable<Task> = Observable()
    //var onTasksChanged: (([Task]) -> Void)?
    
    func getTasks(forUser:  UserModel) {
        self.taskService.fetchTasks(forUser: forUser) { [weak self] tasks in
            self?.taskModels.value = tasks
            //self?.onTasksChanged?(tasks)
        }
    }
    
    func getTask(withId: String) {
        self.taskService.fetchTask(taskId: withId) { [weak self] task in
            self?.taskModel.value = task
        }
    }
    
    func uploadTask(task: Task) {
        self.taskService.uploadTask(task: task) { error, _ in
            if error != nil {
                //костыль
                print("Task Upload Failed")
            }
        }
    }
}
