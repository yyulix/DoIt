//
//  SearchFriendsTableViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class SearchFriendsTableViewController: UITableViewController { // UIViewController и добавить отдельно
    
    // MARK: - Public Properties
    
    static var cellHeight: CGFloat { return 100 } // to Struct

    // MARK: - Private Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSearchController()
    }
    
    // MARK: - Helpers
    
    private func configureUI() { // разбить
        navigationController?.hidesBarsOnSwipe = true
        
        view.backgroundColor = .white
        navigationItem.title = "Find Friend"
        
        tableView.register(FindFriendCell.self, forCellReuseIdentifier: String(describing: FindFriendCell.self))
        tableView.separatorStyle = .none
        
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
        return SearchFriendsTableViewController.cellHeight
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
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
//        searchController.searchBar.tintColor = .white
//        searchController.searchBar.searchTextField.textColor = .orange
//        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
//            string: "Search for a friend", attributes: [.foregroundColor: UIColor.systemGray5])
//        let button = searchController.searchBar.searchTextField.value(forKey: "clearButton") as! UIButton
//        button.setImage(UIImage(systemName: "clear.fill"), for: .normal)
//        button.layer.cornerRadius = button.frame.height / 2
//        button.layer.masksToBounds = true
//        let glassIcon = searchController.searchBar.searchTextField.leftView!
//        glassIcon.tintColor = .white
//        searchController.searchBar.barStyle = .black
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        debugPrint("Searching for : \(searchController.searchBar.text!)")
    }
}
