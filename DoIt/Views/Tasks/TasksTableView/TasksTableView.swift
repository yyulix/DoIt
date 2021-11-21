//
//  TasksTableView.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class TasksTableView: UITableView {

    let tasks = [Task(image: UIImage(named: "bob"), title: "Task 1: Get ready for an exam", description: nil, deadline: nil, isDone: true, creator: nil, color: .black),
                 Task(image: UIImage(named: "bob"), title: nil, description: nil, deadline: nil, isDone: false, creator: nil, color: nil),
                 Task(image: UIImage(named: "bob"), title: "Task 2: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creator: nil, color: .red),
                 Task(image: UIImage(named: "bob"), title: "Task 2: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creator: nil, color: .orange),]


}

extension TasksTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell
        // Data just for example
        cell?.configureCell(taskInfo: tasks[indexPath.row])
        return cell!
    }
}
