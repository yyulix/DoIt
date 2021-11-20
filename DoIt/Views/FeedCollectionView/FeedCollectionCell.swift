//
//  FeedCollectionCell.swift
//  DoIt
//
//  Created by Данил Иванов on 16.11.2021.
//

import UIKit

class FeedCollectionCell: UICollectionViewCell {
    
    // MARK: - Public Property
    static let identifier = "FeedCollectionCell"
    
    // MARK: - Private Property
    private struct UIConstants {
        static let padding = 6.0
        static let topPadding = 18.0
        static let leftPadding = 11.0
        static let rightPadding = -11.0
        static let cornerRadius = 10.0
        static let labelFontSize = 20.0
        static let creatorFontSize = 16.0
        static let taskImageSize = 75.0
        static let creatorImageSize = 30.0
    }
    
    private let taskImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let creatorImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: UIConstants.creatorImageSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: UIConstants.creatorImageSize).isActive = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        return image
    }()
    
    private let creatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.AppColors.minorTextColor
        label.font = label.font.withSize(UIConstants.creatorFontSize)
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
    func configureCell(taskInfo: Task) {
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        configureTaskImage(image: taskInfo.image)
        configureTaskLabel(titleText: taskInfo.title)
        configureCreatorViews()
        contentMode = .scaleAspectFit
        backgroundColor = .white
    }
    
    private func configureTaskImage(image: UIImage?) {
        self.addSubview(taskImage)
        if let _ = image {
            taskImage.image = image
        } else {
            taskImage.image = UIImage.TaskIcons.standartImage
        }
        taskImage.topAnchor.constraint(equalTo: self.topAnchor, constant: UIConstants.topPadding).isActive = true
        taskImage.widthAnchor.constraint(equalToConstant: UIConstants.taskImageSize).isActive = true
        taskImage.heightAnchor.constraint(equalToConstant: UIConstants.taskImageSize).isActive = true
        taskImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func configureTaskLabel(titleText: String?) {
        self.addSubview(taskLabel)
        taskLabel.topAnchor.constraint(equalTo: taskImage.bottomAnchor, constant: UIConstants.padding).isActive = true
        taskLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        taskLabel.textColor = UIColor.AppColors.mainTextColor
        taskLabel.font = taskLabel.font.withSize(UIConstants.labelFontSize)
        if let _ = titleText {
            taskLabel.text = titleText
        } else {
            taskLabel.text = TaskString.title.rawValue.localized
        }
    }
    
    private func configureCreatorViews() {
        //это тут пока не появится что-то для хранения пользоватееля
        creatorImage.image = UIImage(named: "bob")
        creatorLabel.text = "@SpoungeBob"
        let stack = UIStackView(arrangedSubviews: [creatorImage, creatorLabel])
        stack.axis = .horizontal
        stack.spacing = UIConstants.padding
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: UIConstants.padding).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.topPadding).isActive = true
    }
}
