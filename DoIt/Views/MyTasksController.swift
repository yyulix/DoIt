//
//  MyTasksController.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class MyTasksController: UIViewController {

    // MARK: - Private Property
    private struct UIConstants {
        static let topPadding = 10.0
        static let leftPadding = 5.0
        static let rightPadding = -5.0
        static let collectionHeight = 35.0
    }
    
    var collection: ChapterCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 0, height: UIConstants.collectionHeight)
        let collectionView = ChapterCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = collectionView.self
        collectionView.dataSource = collectionView.self
        collectionView.register(ChapterCollectionViewCell.self, forCellWithReuseIdentifier: "ChapterCollectionCell")
        return collectionView
    }()
    
    var table: TasksTableView = {
        let tableView = TasksTableView()
        tableView.dataSource = tableView.self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
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
