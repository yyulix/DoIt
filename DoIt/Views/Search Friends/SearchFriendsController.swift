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
        static let durationSearchBar: CGFloat = 0.2
        static let typeOfAnimation: UIView.AnimationOptions = .curveLinear
        static let visibleOpacity: CGFloat = 1
        static let transparentValue: Float = 0
        static let opaqueValue: Float = 1
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(FindFriendCell.self, forCellReuseIdentifier: String(describing: FindFriendCell.self))
        table.dataSource = self
        table.delegate = self
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = Constants.backgroundColor
        return table
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = FindFriendsString.searchPlaceholder.rawValue.localized
        searchBar.delegate = self
        searchBar.textContentType = .nickname
        searchBar.showsCancelButton = false
        
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.tintColor = .white
        return searchBar
    }()
    
    private lazy var openSearchButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(self, action: #selector(addSearchBarView), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = FindFriendsString.header.rawValue.localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(tableView)

        layoutTableView()
        configureNavigationController()
    }

    private func configureNavigationController() {
        navigationItem.title = FindFriendsString.header.rawValue.localized
        definesPresentationContext = true
        
        navigationItem.titleView = titleView
        navigationItem.setRightBarButton(openSearchButton, animated: true)
    }

    private func layoutTableView() {
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension SearchFriendsController {
    @objc
    private func addSearchBarView() {
        UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation) {
            self.navigationController?.navigationBar.tintColor = .clear
            self.navigationItem.titleView?.layer.opacity = Constants.transparentValue
        } completion: { _ in
            self.navigationItem.setHidesBackButton(true, animated: false)
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = self.searchBar
            self.navigationItem.titleView?.layer.opacity = Constants.transparentValue
            UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation) {
                self.navigationItem.titleView?.layer.opacity = Constants.opaqueValue
            } completion: { _ in
                self.searchBar.setShowsCancelButton(true, animated: true)
                self.searchBar.becomeFirstResponder()
            }
        }
    }

    func removeSearchBarView() {
        searchBar.setShowsCancelButton(false, animated: true)
        UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation) {
            self.navigationItem.titleView?.layer.opacity = Constants.transparentValue
        } completion: { _ in
            self.navigationItem.setHidesBackButton(false, animated: false)
            self.navigationItem.titleView = self.titleView
            self.navigationItem.rightBarButtonItem = self.openSearchButton
            UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation) {
                self.navigationController?.navigationBar.tintColor = .systemBackground
                self.navigationItem.titleView?.layer.opacity = Constants.opaqueValue
            } completion: { _ in
                
            }
        }
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
        cell.configureCell(with: SearchFriendsModel(image: nil, login: nil, summery: nil, isFollowed: nil))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SearchFriendsController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        searchBar.endEditing(true)
        
        removeSearchBarView()
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
