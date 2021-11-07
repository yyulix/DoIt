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
        static let topPadding = 15.0
        static let leftPadding = 5.0
        static let rightPadding = -5.0
        static let collectionHeight = 50.0
    }
    
    private let table = TasksTableViewController()
    private let collection = ChapterCollectionViewController(collectionViewLayout: UICollectionViewLayout())
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutCollection()
        layoutTable()
    }
    
    //MARK: - Private Methods
    private func layoutCollection() {
        view.addSubview(collection.collectionView)
        collection.collectionView.translatesAutoresizingMaskIntoConstraints = false
        collection.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.topPadding).isActive = true
        collection.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.collectionView.heightAnchor.constraint(equalToConstant: UIConstants.collectionHeight).isActive = true
    }
    
    private func layoutTable() {
        view.addSubview(table.tableView)
        table.tableView.translatesAutoresizingMaskIntoConstraints = false
        table.tableView.topAnchor.constraint(equalTo: collection.collectionView.bottomAnchor, constant: UIConstants.topPadding).isActive = true
        table.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        table.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        table.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
