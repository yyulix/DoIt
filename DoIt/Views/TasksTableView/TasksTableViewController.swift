//
//  TasksTableViewController.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class TasksTableViewController: UITableViewController {

    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell
        // Data just for example
        if indexPath.item < 4 {
            let data = TaskStruct(image: UIImage(named: "bob"),
                                  title: "Task 1: Get ready for an exam",
                                  description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf",
                                  deadline: nil,
                                  isDone: false,
                                  creator: 12345,
                                  color: .orange)
            cell?.configureCell(taskInfo: data)
        } else {
            let data = TaskStruct(image: nil,
                              title: nil,
                              description: nil,
                              deadline: nil,
                              isDone: true,
                              creator: 12345,
                              color: .red)
            cell?.configureCell(taskInfo: data)
        }
        return cell!
    }

}
