//
//  ChapterCollectionView.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class ChapterCollectionView: UICollectionView, UICollectionViewDelegate {

    // MARK: - Private Property
    private struct UIConstants {
        static let cellWidth = 190.0
        static let cellHeight = 35.0
    }
    
    private var chapters = [Chapter(title: "Все задачи", color: .gray, textColor: .white),
                    Chapter(title: "Работа", color: .orange, textColor: .black),
                    Chapter(title: "Учеба", color: .green, textColor: .gray),
                    Chapter(title: "Саморазвитие", color: .systemTeal, textColor: .white),
                    Chapter(title: "Семья", color: .yellow, textColor: .gray),
                    Chapter(title: "Проживание. Счета", color: .red, textColor: .black)]
    
}

extension ChapterCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterCollectionCell", for: indexPath) as? ChapterCollectionViewCell else { return .init(frame: .zero) }
        cell.configureCell(chapterData: chapters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chapters.count
    }
}
