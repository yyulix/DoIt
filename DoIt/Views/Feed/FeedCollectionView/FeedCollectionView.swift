//
//  FeedCollectionView.swift
//  DoIt
//
//  Created by Данил Иванов on 16.11.2021.
//

import UIKit

class FeedCollectionView: UICollectionView, UICollectionViewDelegate {
    
    private struct UIConstants {
        static let cellHeight = 190.0
        static let collectionInset: CGFloat = 10.0
    }
    
    let tasks = [Task(image: UIImage(named: "bob"), title: "Поменять резину", description: nil, deadline: nil, isDone: true, creator: nil, color: .black),
                 Task(image: UIImage(named: "duck"), title: nil, description: nil, deadline: nil, isDone: false, creator: nil, color: nil),
                 Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creator: nil, color: .red),
                 Task(image: UIImage(named: "duck"), title: "Почистить зубы", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creator: nil, color: .orange),
                 Task(image: UIImage(named: "duck"), title: nil, description: nil, deadline: nil, isDone: false, creator: nil, color: nil),
                 Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creator: nil, color: .red),
                 Task(image: UIImage(named: "duck"), title: "Почистить зубы", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: true, creator: nil, color: .orange),
                 Task(image: UIImage(named: "duck"), title: nil, description: nil, deadline: nil, isDone: false, creator: nil, color: nil),
                 Task(image: UIImage(named: "bob"), title: "Отдохнуть", description: "Math exam. jad;lfajslf;jasl;dfjlskfja;sldf", deadline: nil, isDone: false, creator: nil, color: .red)]
}

extension FeedCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionCell", for: indexPath) as? FeedCollectionCell else { return .init(frame: .zero) }
        cell.configureCell(taskInfo: tasks[indexPath.row])
        return cell
    }
}

extension FeedCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: (self.frame.width / 2 - 2 * UIConstants.collectionInset), height: UIConstants.cellHeight)
    }
}

