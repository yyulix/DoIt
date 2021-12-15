//
//  SearchFriendsTableViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class SearchUsersController: UIViewController {
    // MARK: - Properties

    struct Constants {
        static let cellHeight: CGFloat = 90
        static let durationSearchBar: CGFloat = 0.2
        static let typeOfAnimation: UIView.AnimationOptions = .curveEaseInOut
        static let opacityValueToAnimate: CGFloat = 0.1
    }

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchUsersCell.self, forCellReuseIdentifier: String(describing: SearchUsersCell.self))
        table.dataSource = self
        table.delegate = self
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = FindUsersStrings.searchPlaceholder.rawValue.localized
        searchBar.delegate = self
        searchBar.textContentType = .nickname
        searchBar.showsCancelButton = false
        searchBar.tintColor = .AppColors.navigationTextColor
        
        searchBar.searchTextField.leftView?.tintColor = .gray
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.backgroundColor = .AppColors.navigationTextColor
        return searchBar
    }()
    
    private lazy var openSearchButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.SearchFriendsIcons.searchIcon, for: .normal)
        button.addTarget(self, action: #selector(addSearchBarView), for: .touchUpInside)
        button.tintColor = .AppColors.navigationTextColor
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = FindUsersStrings.header.rawValue.localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .AppColors.navigationTextColor
        return label
    }()
    
    var viewModel: SearchUsersViewModel = SearchUsersViewModel()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.userModel.bind { [weak self] _ in
            self?.viewModel.getAllUsers()
        }
        
        viewModel.userModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            }
        }
        
        viewModel.filteredUsersModel.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            }
        }
        
        configureUI()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground

        configureNavigationController()
        layoutTableView()
    }

    private func configureNavigationController() {
        navigationItem.title = FindUsersStrings.header.rawValue.localized
        navigationItem.titleView = titleView
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setRightBarButton(openSearchButton, animated: false)
    }

    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func configureNavigationControllerAnimation(withSearchBar: Bool, completion: ((Bool) -> ())? = nil) {
        let alphaColor: UIColor = .AppColors.navigationTextColor.withAlphaComponent(Constants.opacityValueToAnimate)

        navigationItem.setHidesBackButton(withSearchBar, animated: false)
        navigationItem.rightBarButtonItem = withSearchBar ? nil : openSearchButton
        navigationItem.titleView = withSearchBar ? self.searchBar : titleView
        navigationItem.titleView?.layer.opacity = Float(Constants.opacityValueToAnimate)

        UIView.animate(withDuration: 0, animations: {
            self.navigationController?.navigationBar.tintColor = alphaColor
        }, completion: { _ in
            self.setDefaultNavigationControllerAnimation(completion: completion)
        })
    }
    
    func setDefaultNavigationControllerAnimation(completion: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation, animations: {
            self.navigationItem.rightBarButtonItem?.customView?.tintColor = .AppColors.navigationTextColor
            self.navigationItem.titleView?.layer.opacity = 1
            self.navigationController?.navigationBar.tintColor = .AppColors.navigationTextColor
        }, completion: completion)
    }
}

extension SearchUsersController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchUsersController.Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileViewController = ProfileViewController()
        profileViewController.viewModel.userModel.value = viewModel.filteredUsersModel.value?[indexPath.row] ?? viewModel.userModels.value?[indexPath.row]
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension SearchUsersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredUsersModel = viewModel.filteredUsersModel.value {
            return filteredUsersModel.count
        }
        return viewModel.userModels.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchUsersCell.self), for: indexPath) as? SearchUsersCell else {
            return .init()
        }
        cell.indexPathRow = indexPath.row
        guard viewModel.filteredUsersModel.value == nil else {
            cell.configureCell(with: viewModel.filteredUsersModel.value![indexPath.row])
            viewModel.downloadImage(viewModel.filteredUsersModel.value![indexPath.row].image) { image in
                DispatchQueue.main.async {
                    cell.configureImage(image: image)
                }
            }
            return cell
        }
        if let userModels = viewModel.userModels.value {
            cell.configureCell(with: userModels[indexPath.row])
            viewModel.downloadImage(userModels[indexPath.row].image) { image in
                DispatchQueue.main.async {
                    cell.configureImage(image: image)
                }
            }
        }
        return cell
    }
}

// MARK: - Actions

extension SearchUsersController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { viewModel.stopFiltering(); return }
        viewModel.filtering(username: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        searchBar.endEditing(true)
        
        removeSearchBarView()
    }
}

extension SearchUsersController: SearchUsersCellDelegate {
    func didTapFollowButton(_ indexPath: Int?, completion: @escaping () -> ()) {
        guard let indexPath = indexPath else { return }
        var userModel: UserModel?
        if let user = viewModel.filteredUsersModel.value?[indexPath] { userModel = user }
        if let user = viewModel.userModels.value?[indexPath] { userModel = user }
        guard let userModel = userModel else { return }
        guard let isFollowed = userModel.isFollowed else { return }
        isFollowed ? unfollowUser(userModel, completion: completion) : followUser(userModel, completion: completion)
    }
    
    private func followUser(_ user: UserModel, completion: @escaping () -> ()) {
        viewModel.followUser(user) { done in
            guard done else {
                
                return
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    private func unfollowUser(_ user: UserModel, completion: @escaping () -> ()) {
        viewModel.unfollowUser(user) { done in
            guard done else {
                
                return
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

extension SearchUsersController {
    @objc
    private func addSearchBarView() {
        let alphaColor: UIColor = .AppColors.navigationTextColor.withAlphaComponent(Constants.opacityValueToAnimate)
        
        UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation) {
            self.navigationController?.navigationBar.tintColor = alphaColor
            self.navigationItem.titleView?.layer.opacity = Float(Constants.opacityValueToAnimate)
            self.navigationItem.rightBarButtonItem?.customView?.tintColor = alphaColor
        } completion: { _ in
            self.configureNavigationControllerAnimation(withSearchBar: true) { _ in
                self.searchBar.setShowsCancelButton(true, animated: true)
                self.searchBar.becomeFirstResponder()
            }
        }
    }
    
    func removeSearchBarView() {
        searchBar.setShowsCancelButton(false, animated: true)
        
        UIView.animate(withDuration: Constants.durationSearchBar, delay: 0, options: Constants.typeOfAnimation) {
            self.navigationItem.titleView?.layer.opacity = Float(Constants.opacityValueToAnimate)
        } completion: { _ in
            self.configureNavigationControllerAnimation(withSearchBar: false)
        }
    }
}
