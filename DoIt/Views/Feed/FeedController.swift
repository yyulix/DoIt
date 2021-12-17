//
//  FeedController.swift
//  DoIt
//
//  Created by Данил Иванов on 16.11.2021.
//

import UIKit

class FeedController: UIViewController {

    private struct UIConstants {
        static let collectionInset = 10.0
        static let cellHeight = 190.0
    }
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.SearchFriendsIcons.searchIcon, for: .normal)
        button.addTarget(self, action: #selector(openSearch), for: .touchUpInside)
        button.tintColor = .AppColors.navigationTextColor
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width * 0.5 - UIConstants.collectionInset * 1.5, height: UIConstants.cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: UIConstants.collectionInset,
                                                   left: UIConstants.collectionInset,
                                                   bottom: UIConstants.collectionInset,
                                                   right: UIConstants.collectionInset)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.self.description())
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var viewModel: FeedViewModel = FeedViewModel()
    
    private var swipeToMyTasks: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openToTasksVC), name: .openTasksFromProfile, object: nil)
        
        viewModel.userModel.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.configureNavigationController()
                self?.viewModel.getFollowing()
            }
        }
        
        viewModel.userFollowing.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.getFollowingTasks()
            }
        }
        
        viewModel.userFollowingTasks.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.collection.reloadData()
            }
        }
        
        viewModel.getCurrentUser()
        
        view.backgroundColor = .systemBackground
        layoutCollection()
        configureNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.getFollowing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if swipeToMyTasks {
            NotificationCenter.default.post(name: .openTasksFromFeed, object: nil)
            swipeToMyTasks = false
        }
    }
    
    private func configureNavigationController() {
        navigationItem.title = (viewModel.userModel.value?.isCurrentUser ?? false) ? FeedStrings.header.rawValue.localized : FeedStrings.allTasksHeader.rawValue.localized
        navigationItem.rightBarButtonItem = (viewModel.userModel.value?.isCurrentUser ?? false) ? searchButton : nil
    }
    
    private func layoutCollection() {
        view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userFollowingTasks.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.self.description(), for: indexPath) as? FeedCollectionViewCell else { return .init() }
        guard let taskInfo = viewModel.userFollowingTasks.value?[indexPath.row] else { return cell }
        guard let userInfo = viewModel.userFollowing.value?.first(where: { $0.uid == taskInfo.uid }) else { return cell }
        cell.tapOnUser = { [weak self] in
            let profileViewController = ProfileViewController()
            profileViewController.viewModel.userModel.value = userInfo
            self?.navigationController?.pushViewController(profileViewController, animated: true)
        }
        cell.configureCell(taskInfo: taskInfo, userInfo: userInfo)
        viewModel.downloadImage(taskInfo.image) { [weak self] image in
            if let oldCell = self?.collection.cellForItem(at: indexPath) as? FeedCollectionViewCell {
                oldCell.configureImage(taskImage: image)
            }
        }
        viewModel.downloadImage(userInfo.image) { [weak self] image in
            if let oldCell = self?.collection.cellForItem(at: indexPath) as? FeedCollectionViewCell {
                oldCell.configureImage(userImage: image)
            }
        }
        return cell
    }
}

// MARK: - Actions

extension FeedController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let taskViewController = TaskViewController()
        taskViewController.viewModel.taskModel.value = viewModel.userFollowingTasks.value?[indexPath.row]
        taskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension FeedController {
    @objc
    private func openSearch() {
        let searchUsersController = SearchUsersController()
        navigationController?.pushViewController(searchUsersController, animated: true)
    }
    
    @objc
    private func openToTasksVC() {
        swipeToMyTasks = true
    }
}
