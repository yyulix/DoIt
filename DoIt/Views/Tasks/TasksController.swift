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
    
    private lazy var profileButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.AuthIcons.personIcon, for: .normal)
        button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        button.tintColor = .AppColors.navigationTextColor
        return UIBarButtonItem(customView: button)
    }()
    
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
    
    var tasks: [Task] = [
//        Task(image: UIImage(named: "bob"), title: "Task 1: Get ready for an exam", description: nil, deadline: nil, isDone: true, creatorId: "1", color: .black, chapterId: 0, creationTime: Date(), isMyTask: true),
//        Task(image: UIImage(named: "bob"), title: "Task 2: Get ready for an exam", description: nil, deadline: nil, isDone: false, creatorId: "2", color: .yellow, chapterId: 1, creationTime: Date(), isMyTask: true),
//        Task(image: UIImage(named: "bob"), title: "Task 3: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: "2", color: .red, chapterId: 2, creationTime: Date(), isMyTask: true),
//        Task(image: UIImage(named: "bob"), title: "Task 4: Get ready for an exam", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: Date(timeIntervalSinceNow: 50), isDone: true, creatorId: "1", color: .orange, chapterId: 3, creationTime: Date(), isMyTask: true)
    ]
    
    private var selectedTasks: [Task]? {
        didSet {
            table.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
    private var previousSelectedChapterId = -1
    
    private let chapters = (0...(TaskCategory.chaptersCount - 1)).map({ TaskCategory(index: $0) })
    
    var userModel: UserModel?
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationController()
        view.addSubview(table)
        layoutCollection()
        layoutTable()
    }
    
    //MARK: - Private Methods
    private func configureNavigationController() {
        navigationItem.title = TasksStrings.header.rawValue.localized
        navigationItem.rightBarButtonItem = (userModel?.isCurrentUser ?? false) ? profileButton : nil
    }
    
    private func layoutCollection() {
        view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.topPadding).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.heightAnchor.constraint(equalToConstant: UIConstants.collectionHeight).isActive = true
    }
    
    private func layoutTable() {
        table.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: UIConstants.topPadding).isActive = true
        table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension TasksController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTasks?.count ?? tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskTableViewCell.self), for: indexPath) as? TaskTableViewCell else { return .init(frame: .zero) }
        cell.configureCell(taskInfo: selectedTasks?[indexPath.row] ?? tasks[indexPath.row])
        return cell
    }
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

// MARK: - Actions

extension TasksController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newSelectedTasks = tasks.filter({ $0.chapterId == indexPath.row })
        guard previousSelectedChapterId != indexPath.row else {
            previousSelectedChapterId = -1
            selectedTasks = nil
            return
        }
        selectedTasks = newSelectedTasks
        previousSelectedChapterId = indexPath.row
    }
}

extension TasksController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = TaskViewController()
        taskViewController.taskModel = selectedTasks?[indexPath.row] ?? tasks[indexPath.row]
        taskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension TasksController {
    @objc
    private func openProfile() {
        let profileViewController = ProfileViewController()
        profileViewController.viewModel.userModel.value = userModel
        guard let userModel = userModel else {
            navigationController?.pushViewController(profileViewController, animated: true)
            return
        }
        profileViewController.viewModel.userTasksModel.value = UserTasksModel(login: userModel.username, tasks: tasks)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
