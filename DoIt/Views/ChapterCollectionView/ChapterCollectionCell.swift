//
//  ChapterCollectionViewCell.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    // MARK: - Public Property
    static let identifier = "CollectionCell"
    
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
    
    //MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configureCell(chapterData: Chapter) {
        addSubview(chapterLabel)
        chapterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        chapterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        chapterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        chapterLabel.font = chapterLabel.font.withSize(UIConstants.labelFontSize)
        chapterLabel.text = chapterData.title!
        chapterLabel.textColor = chapterData.textColor!
        backgroundColor = chapterData.color!
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        contentMode = .scaleAspectFit
    }
}
