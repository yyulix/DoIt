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
    
    private let tasks = [Task(image: UIImage(named: "bob"), title: "Поменять резину", description: nil, deadline: nil, isDone: true, creatorId: 23, color: .black),
                         Task(image: UIImage(named: "duck"), title: "Купиить шапку", description: nil, deadline: nil, isDone: false, creatorId: 23, color: .yellow),
                 Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: 23, color: .red),
                 Task(image: UIImage(named: "duck"), title: "Почистить зубы", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creatorId: 23, color: .orange),
                         Task(image: UIImage(named: "duck"), title: "Занятие по танцам", description: nil, deadline: nil, isDone: false, creatorId: 23, color: .black),
                 Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: 23, color: .red),
                 Task(image: UIImage(named: "duck"), title: "Почистить зубы", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creatorId: 23, color: .orange),
                         Task(image: UIImage(named: "duck"), title: "Оплатить счета", description: nil, deadline: nil, isDone: false, creatorId: 23, color: .orange),
                 Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creatorId: 23, color: .red)]
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.collection.frame.width * 0.5 - 3 * UIConstants.collectionInset * 2, height: UIConstants.cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: UIConstants.collectionInset,
                                                   left: UIConstants.collectionInset,
                                                   bottom: UIConstants.collectionInset,
                                                   right: UIConstants.collectionInset)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "FeedCollectionCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutCollection()
    }
    
    private func layoutCollection() {
        view.addSubview(collection)
        collection.backgroundColor = UIColor.AppColors.feedBackgroundColor
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionCell", for: indexPath) as? FeedCollectionViewCell else { return .init(frame: .zero) }
        cell.configureCell(taskInfo: tasks[indexPath.row])
        return cell
    }
}
