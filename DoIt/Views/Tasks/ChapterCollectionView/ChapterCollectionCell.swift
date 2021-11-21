//
//  ChapterCollectionViewCell.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class ChapterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Property
    private struct UIConstants {
        static let leftPadding = 11.0
        static let rightPadding = -11.0
        static let cornerRadius = 15.0
        static let labelFontSize = 18.0
    }
    
    private let chapterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Public Methods
    func configureCell(chapterData: Chapter) {
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        contentMode = .scaleAspectFit
        configureChapterLabel()
        configureData(chapterData: chapterData)
    }
    
    private func configureChapterLabel() {
        addSubview(chapterLabel)
        chapterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        chapterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        chapterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        chapterLabel.font = chapterLabel.font.withSize(UIConstants.labelFontSize)
    }
    
    private func configureData(chapterData: Chapter) {
        chapterLabel.text = chapterData.title!
        chapterLabel.textColor = chapterData.textColor!
        backgroundColor = chapterData.color!
    }
}
