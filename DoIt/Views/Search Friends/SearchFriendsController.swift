//
//  SearchFriendsTableViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class SearchFriendsController: UIViewController {
    // MARK: - Properties

    struct Constants {
        static let cellHeight: CGFloat = 90
        static let backgroundColor: UIColor = .white
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(FindFriendCell.self, forCellReuseIdentifier: String(describing: FindFriendCell.self))
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private let searchController = CustomSearchController(placeholder: FindFriendsString.searchPlaceholder.rawValue.localized)

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)
        configureTableView()
        configureConstraintsForTableView()
        
        configureNavigationController()
        configureSearchController()
    }

    private func configureNavigationController() {
        navigationItem.title = FindFriendsString.header.rawValue.localized
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backgroundColor
    }

    private func configureConstraintsForTableView() {
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension SearchFriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchFriendsController.Constants.cellHeight
    }
}

extension SearchFriendsController: UITableViewDataSource {
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

extension SearchFriendsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    private func configureSearchController() {
        searchController.searchResultsUpdater = self
    }
}

extension SearchFriendsController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
