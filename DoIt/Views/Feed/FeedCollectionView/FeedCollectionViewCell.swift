//
//  FeedCollectionViewCell.swift
//  DoIt
//
//  Created by Данил Иванов on 16.11.2021.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
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
    
    private lazy var taskImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIConstants.labelFontSize)
        return label
    }()
    
    private lazy var creatorImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: UIConstants.creatorImageSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: UIConstants.creatorImageSize).isActive = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUser)))
        return image
    }()
    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.font = label.font.withSize(UIConstants.creatorFontSize)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUser)))
        return label
    }()
    
    var tapOnUser: (() -> ())?
    
    //MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configureCell(taskInfo: Task, userInfo: UserModel) {
        taskImage.image = taskInfo.image ?? UIImage.TaskIcons.defaultImage
        taskLabel.text = taskInfo.title
        creatorLabel.text = "@" + userInfo.username
        guard let image = userInfo.image else {
            creatorImage.layoutIfNeeded()
            creatorImage.setImageForName(userInfo.name ?? userInfo.username, circular: false, textAttributes: nil)
            return
        }
        creatorImage.image = image
    }
    
    private func configureUI() {
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        backgroundColor = .systemBackground
        contentView.isUserInteractionEnabled = false
        
        configureTaskImage()
        configureTaskLabel()
        configureCreatorViews()
    }
    
    private func configureTaskImage() {
        addSubview(taskImage)
        taskImage.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.topPadding).isActive = true
        taskImage.widthAnchor.constraint(equalToConstant: UIConstants.taskImageSize).isActive = true
        taskImage.heightAnchor.constraint(equalToConstant: UIConstants.taskImageSize).isActive = true
        taskImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func configureTaskLabel() {
        addSubview(taskLabel)
        taskLabel.topAnchor.constraint(equalTo: taskImage.bottomAnchor, constant: UIConstants.padding).isActive = true
        taskLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UIConstants.rightPadding).isActive = true
    }
    
    private func configureCreatorViews() {
        let stack = UIStackView(arrangedSubviews: [creatorImage, creatorLabel])
        stack.axis = .horizontal
        stack.spacing = UIConstants.padding
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: taskLabel.bottomAnchor, constant: UIConstants.padding).isActive = true
        stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.leftPadding).isActive = true
        stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: UIConstants.rightPadding).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.topPadding).isActive = true
    }
    
    @objc
    private func openUser() {
        tapOnUser?()
    }
}
