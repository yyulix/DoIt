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
        label.font = .systemFont(ofSize: UIConstants.labelFontSize)
        label.textColor = .black
        return label
    }()
    
    //MARK: - Public Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: Chapter) {
        chapterLabel.text = model.title
        backgroundColor = model.color
    }
    
    private func configureUI() {
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        configureChapterLabel()
    }
    
    private func configureChapterLabel() {
        addSubview(chapterLabel)
        chapterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        chapterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        chapterLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
