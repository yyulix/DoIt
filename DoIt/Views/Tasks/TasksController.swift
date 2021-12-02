//
//  MyTasksController.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class TasksController: UIViewController {

    // MARK: - Private Property
    private let tasks = [Task(image: UIImage(named: "bob"), title: "Task 1: Get ready for an exam", description: nil, deadline: nil, isDone: true, creatorId: 23, color: .black),
                         Task(image: UIImage(named: "bob"), title: "Task 2: Get ready for an exam", description: nil, deadline: nil, isDone: false, creatorId: 23, color: .yellow),
                 Task(image: UIImage(named: "bob"), title: "Task 3: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: 23, color: .red),
                 Task(image: UIImage(named: "bob"), title: "Task 4: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creatorId: 23, color: .orange)]
    
    private var chapters = [Chapter(title: "Все задачи", color: .gray, textColor: .white),
                    Chapter(title: "Работа", color: .orange, textColor: .black),
                    Chapter(title: "Учеба", color: .green, textColor: .gray),
                    Chapter(title: "Саморазвитие", color: .systemTeal, textColor: .white),
                    Chapter(title: "Семья", color: .yellow, textColor: .gray),
                    Chapter(title: "Проживание. Счета", color: .red, textColor: .black)]
    
    private struct UIConstants {
        static let topPadding = 10.0
        static let leftPadding = 5.0
        static let rightPadding = -5.0
        static let collectionHeight = 35.0
    }
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 0, height: UIConstants.collectionHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(ChapterCollectionViewCell.self, forCellWithReuseIdentifier: "ChapterCollectionCell")
        return collectionView
    }()
    
    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutCollection()
        layoutTable()
    }
    
    //MARK: - Private Methods
    private func layoutCollection() {
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.topPadding).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.heightAnchor.constraint(equalToConstant: UIConstants.collectionHeight).isActive = true
    }
    
    private func layoutTable() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: UIConstants.topPadding).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension TasksController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TaskTableViewCell else { return .init(frame: .zero) }
        cell.configureCell(taskInfo: tasks[indexPath.row])
        return cell
    }
}

extension TasksController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCollectionCell", for: indexPath) as? ChapterCollectionViewCell else { return .init(frame: .zero) }
        cell.configureCell(chapterData: chapters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapters.count
    }
}
