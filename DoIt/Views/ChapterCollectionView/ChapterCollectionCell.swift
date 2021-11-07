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
        static let cornerRadius = 25.0
        static let labelFontSize = 24.0
    }
    
    private let label: UILabel = {
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
    func configureCell(chapterData: ChapterStruct) {
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.font = label.font.withSize(UIConstants.labelFontSize)
        label.text = chapterData.title!
        label.textColor = chapterData.textColor!
        backgroundColor = chapterData.color!
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        contentMode = .scaleAspectFit
    }
}
