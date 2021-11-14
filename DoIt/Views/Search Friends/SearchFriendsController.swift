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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = FindFriendsString.searchPlaceholder.rawValue.localized
        searchBar.delegate = self
        searchBar.textContentType = .nickname
        searchBar.showsCancelButton = true
        
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.tintColor = .white
        return searchBar
    }()
    
    private lazy var openSearchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(addSearchBar))

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
        layoutTableView()
        configureNavigationController()
    }

    private func configureNavigationController() {
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = FindFriendsString.header.rawValue.localized
        definesPresentationContext = true
        
        navigationItem.setRightBarButton(openSearchButton, animated: true)
    }

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.backgroundColor
    }

    private func layoutTableView() {
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc
    private func addSearchBar() {
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
        searchBar.setShowsCancelButton(true, animated: true)
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
        cell.configureCell(with: SearchFriendsModel(image: nil, login: "login", summery: "Summery", isFollowed: true))
        return cell
    }
}

extension SearchFriendsController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        
        removeSearchBarView()
    }
    
    func removeSearchBarView() {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = openSearchButton
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
