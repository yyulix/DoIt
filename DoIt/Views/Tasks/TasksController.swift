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
    
    private let viewModel: TasksViewModel = TasksViewModel()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.userModel.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.configureNavigationController()
                self?.viewModel.getTasks()
            }
        }
        
        viewModel.taskModels.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.table.reloadData()
            }
        }
        viewModel.selectedTaskModels.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.table.reloadSections(IndexSet(integer: 0), with: .fade)
            }
        }
        viewModel.getCurrentUser()
        
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        configureNavigationController()
        layoutCollection()
        layoutTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.taskModels.value = nil
        viewModel.selectedTaskModels.value = nil
        viewModel.getCurrentUser()
    }
    
    //MARK: - Private Methods
    
    private func configureNavigationController() {
        navigationItem.title = TasksStrings.header.rawValue.localized
        navigationItem.rightBarButtonItem = (viewModel.userModel.value?.isCurrentUser ?? false) ? profileButton : nil
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
        if let selectedTasks = viewModel.selectedTaskModels.value {
            return selectedTasks.count
        }
        return viewModel.taskModels.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskTableViewCell.self), for: indexPath) as? TaskTableViewCell else { return .init(frame: .zero) }
        if let selectedTask = viewModel.selectedTaskModels.value?[indexPath.row] {
            cell.configureCell(taskInfo: selectedTask)
            viewModel.downloadImage(selectedTask.image) { [weak self] image in
                if let oldCell = self?.table.cellForRow(at: indexPath) as? TaskTableViewCell {
                    oldCell.configure(taskImage: image)
                }
            }
            return cell
        }
        guard let task = viewModel.taskModels.value?[indexPath.row] else { return cell }
        cell.configureCell(taskInfo: task)
        viewModel.downloadImage(task.image) { [weak self] image in
            if let oldCell = self?.table.cellForRow(at: indexPath) as? TaskTableViewCell {
                oldCell.configure(taskImage: image)
            }
        }
        return cell
    }
}

extension TasksController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.chapters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChapterCollectionViewCell.self), for: indexPath) as? ChapterCollectionViewCell else { return .init(frame: .zero) }
        cell.configureCell(with: viewModel.chapters[indexPath.row].chapter)
        return cell
    }
}

// MARK: - Actions

extension TasksController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.filterTasks(row: indexPath.row)
    }
}

extension TasksController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskViewController = TaskViewController()
        taskViewController.viewModel.taskModel.value = viewModel.selectedTaskModels.value?[indexPath.row] ?? viewModel.taskModels.value?[indexPath.row]
        taskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension TasksController {
    @objc
    private func openProfile() {
        guard let userModel = viewModel.userModel.value else {
            return
        }
        let profileViewController = ProfileViewController()
        profileViewController.viewModel.userModel.value = userModel
        guard let taskModels = viewModel.taskModels.value else {
            navigationController?.pushViewController(profileViewController, animated: true)
            return
        }
        profileViewController.viewModel.userTasksModel.value = UserTasksModel(login: userModel.username, tasks: taskModels)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}
