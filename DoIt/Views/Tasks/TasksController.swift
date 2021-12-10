//
//  MyTasksController.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class TasksController: UIViewController {

    // MARK: - Private Property
    
    private struct UIConstants {
        static let topPadding = 10.0
        static let leftPadding = 5.0
        static let rightPadding = -5.0
        static let collectionHeight = 35.0
    }
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 100, height: UIConstants.collectionHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChapterCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ChapterCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: String(describing: TaskTableViewCell.self))
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let tasks = [
        Task(image: UIImage(named: "bob"), title: "Task 1: Get ready for an exam", description: nil, deadline: nil, isDone: true, creatorId: "1", color: .black, chapterId: 0, creationTime: Date(), isMyTask: true),
        Task(image: UIImage(named: "bob"), title: "Task 2: Get ready for an exam", description: nil, deadline: nil, isDone: false, creatorId: "2", color: .yellow, chapterId: 1, creationTime: Date(), isMyTask: true),
        Task(image: UIImage(named: "bob"), title: "Task 3: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: "2", color: .red, chapterId: 2, creationTime: Date(), isMyTask: true),
        Task(image: UIImage(named: "bob"), title: "Task 4: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: Date(timeIntervalSinceNow: 50), isDone: true, creatorId: "1", color: .orange, chapterId: 3, creationTime: Date(), isMyTask: true)
    ]
    
    private let chapters = (0...(TaskCategory.chaptersCount - 1)).map({ TaskCategory(index: $0) })
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationController()
        layoutCollection()
        layoutTable()
    }
    
    //MARK: - Private Methods
    private func configureNavigationController() {
        navigationItem.title = TasksStrings.header.rawValue.localized
    }
    
    private func layoutCollection() {
        view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.topPadding).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.heightAnchor.constraint(equalToConstant: UIConstants.collectionHeight).isActive = true
    }
    
    private func layoutTable() {
        view.addSubview(table)
        table.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: UIConstants.topPadding).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension TasksController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = TaskViewController()
        taskViewController.taskModel = tasks[indexPath.row]
        taskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension TasksController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskTableViewCell.self), for: indexPath) as? TaskTableViewCell else { return .init(frame: .zero) }
        cell.configureCell(taskInfo: tasks[indexPath.row])
        return cell
    }
}

extension TasksController: UICollectionViewDelegate {
    
}

extension TasksController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChapterCollectionViewCell.self), for: indexPath) as? ChapterCollectionViewCell else { return .init(frame: .zero) }
        cell.configureCell(with: chapters[indexPath.row].chapter)
        return cell
    }
}
