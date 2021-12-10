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
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width * 0.5 - UIConstants.collectionInset * 1.5, height: UIConstants.cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: UIConstants.collectionInset,
                                                   left: UIConstants.collectionInset,
                                                   bottom: UIConstants.collectionInset,
                                                   right: UIConstants.collectionInset)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.self.description())
        collectionView.backgroundColor = UIColor.AppColors.feedBackgroundColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var following = [
        UserModel(image: nil, name: "wfqjoapfa", login: "fqFJqow", summary: nil, statistics: UserStatisticsModel(inProgress: "0", outdated: "0", done: "1", total: "1"), isMyScreen: false, isFollowed: true),
        UserModel(image: nil, name: "gsgdsgger", login: "GIOWJEOG", summary: nil, statistics: UserStatisticsModel(inProgress: "0", outdated: "0", done: "0", total: "0"), isMyScreen: false, isFollowed: true),
        UserModel(image: nil, name: "greaiojgeo", login: "fwaojfoq", summary: nil, statistics: UserStatisticsModel(inProgress: "0", outdated: "0", done: "0", total: "0"), isMyScreen: true, isFollowed: true)
    ]
    
    private lazy var followersTasks = [
        Task(image: UIImage(named: "bob"), title: "Поменять резину", description: nil, deadline: nil, isDone: true, creatorId: "GIOWJEOG", color: .black, chapterId: 0, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "duck"), title: "Купиить шапку", description: nil, deadline: nil, isDone: false, creatorId: "fqFJqow", color: .yellow, chapterId: 1, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: "fwaojfoq", color: .red, chapterId: 2, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "duck"), title: "Почистить зубы", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creatorId: "fwaojfoq", color: .orange, chapterId: 3, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "duck"), title: "Занятие по танцам", description: nil, deadline: nil, isDone: false, creatorId: "fwaojfoq", color: .black, chapterId: 4, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: "GIOWJEOG", color: .red, chapterId: 5, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "duck"), title: "Почистить зубы", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creatorId: "GIOWJEOG", color: .orange, chapterId: 6, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "duck"), title: "Оплатить счета", description: nil, deadline: nil, isDone: false, creatorId: "GIOWJEOG", color: .orange, chapterId: 7, creationTime: Date(), isMyTask: false),
        Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: "GIOWJEOG", color: .red, chapterId: 8, creationTime: Date(), isMyTask: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutCollection()
        configureNavigationController()
    }
    
    private func configureNavigationController() {
        navigationItem.title = FeedStrings.header.rawValue.localized
    }
    
    private func layoutCollection() {
        view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FeedController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let taskViewController = TaskViewController()
        taskViewController.taskModel = followersTasks[indexPath.row]
        taskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskViewController, animated: true)
    }
}

extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followersTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.self.description(), for: indexPath) as? FeedCollectionViewCell else { return .init(frame: .zero) }
        guard let userInfo = following.first(where: { $0.login == followersTasks[indexPath.row].creatorId }) else { return .init(frame: .zero) }
        cell.tapOnUser = { [weak self] in
            let profileViewController = ProfileViewController()
            profileViewController.configure(with: userInfo)
            self?.navigationController?.pushViewController(profileViewController, animated: true)
        }
        cell.configureCell(taskInfo: followersTasks[indexPath.row], userInfo: userInfo)
        return cell
    }
}
