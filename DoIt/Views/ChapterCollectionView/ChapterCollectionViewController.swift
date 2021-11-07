//
//  ChapterCollectionViewController.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class ChapterCollectionViewController: UICollectionViewController {

    // MARK: - Private Property
    private struct UIConstants {
        static let cellWidth = 190.0
        static let cellHeight = 50.0
    }
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else { return .init(frame: .zero) }
        // Data just for example
        cell.configureCell(chapterData: ChapterStruct(title: "Chapter \(indexPath.row)", color: UIColor.AppColors.accentColor, textColor: .white))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
}

extension ChapterCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
    }
}

    


