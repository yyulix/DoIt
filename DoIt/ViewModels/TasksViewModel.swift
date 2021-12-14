//
//  TasksViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 14.12.2021.
//

import Foundation

protocol TasksViewModel {    
    var preparedTasks: Dynamic<[Task]> { get }
}
