//
//  TasksScreenViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 14.12.2021.
//

import Foundation

class TasksScreenViewModel: NSObject, TasksViewModel {
    var preparedTasks: Dynamic<[Task]>
    var allTasks: [Task]
    let taskService = TaskS
    
    override init() {
        allTasks = taskService.
    }
}
