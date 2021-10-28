//
//  SearchFriendsTableViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class SearchFriendsTableViewController: UIViewController {
    // MARK: - Properties

    struct Constants {
        static let cellHeight: CGFloat = 100
    }
    
    private enum TextConstants: String {
        case titleOfNavigationBar = "Find Friend"
        case placeholderInSearchBar = "Search for a friend"
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(FindFriendCell.self, forCellReuseIdentifier: String(describing: FindFriendCell.self))
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private let searchController = CustomSearchController(placeholder: TextConstants.placeholderInSearchBar.rawValue)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(tableView)
        configureTableView()
        configureConstraintsForTableView()
        
        configureNavigationController()
        configureSearchController()
    }

    private func configureNavigationController() {
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = TextConstants.titleOfNavigationBar.rawValue
        navigationItem.leftBarButtonItem = BackBarButtom()
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    }
    
    private func configureConstraintsForTableView() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SearchFriendsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchFriendsTableViewController.Constants.cellHeight
    }
}

extension SearchFriendsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FindFriendCell.self), for: indexPath) as? FindFriendCell else {
            return .init()
        }
        return cell
    }
}

extension SearchFriendsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
