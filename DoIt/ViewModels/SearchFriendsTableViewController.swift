//
//  SearchFriendsTableViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class SearchFriendsTableViewController: UITableViewController { // UIViewController и добавить отдельно
    // MARK: - Properties

    struct Constants {
        static let cellHeight: CGFloat = 100
    }

    private enum TextConstants: String {
        case titleOfNavigationBar = "Find Friend"
        case placeholderInSearchBar = "Search for a friend"
    }
    
    private let searchController = CustomSearchController(placeholder: TextConstants.placeholderInSearchBar.rawValue)

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationController()
        configureSearchController()
    }

    // MARK: - Helpers

    private func configureTableView() {
        tableView.register(FindFriendCell.self, forCellReuseIdentifier: String(describing: FindFriendCell.self))
        tableView.separatorStyle = .none
    }

    private func configureNavigationController() {
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = TextConstants.titleOfNavigationBar.rawValue
        navigationItem.leftBarButtonItem = BackBarButtom()
    }
}

// MARK: - Table View Data Source

extension SearchFriendsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchFriendsTableViewController.Constants.cellHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FindFriendCell.self), for: indexPath) as? FindFriendCell else {
            return .init()
        }
        return cell
    }
}

// MARK: - Search Results Update

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
