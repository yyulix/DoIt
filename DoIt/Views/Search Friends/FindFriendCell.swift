//
//  FindFriendCell.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class FindFriendCell: UITableViewCell {
    // MARK: - Private Properties

    private struct Constants {
        static let offset: CGFloat = 8
        static let offsetPicture: CGFloat = 16
        static let offsetPictureFromLeft: CGFloat = 10
        static let offsetFollowButtonFromRight: CGFloat = 12
        static let multiplierWidthFollowButton: CGFloat = 0.21
        
        static let defaultCornerRadius: CGFloat = 8
        
        static let loginLabelSizeOfFont: CGFloat = 18
        static let loginLabelNumberOfLines: Int = 1
        
        static let summeryLabelSizeOfFont: CGFloat = 14
        static let summeryLabelNumberOfLines: Int = 0
        
        static let stackViewSpacing: CGFloat = -20
        static let stackViewDistribution: UIStackView.Distribution = .fillEqually
        
        static let followButtonSelectedColor: UIColor = .green
        static let followButtonUnselectedColor: UIColor = .AppColors.accentColor
        static let followButtonSizeOfFont: CGFloat = 15
        static let followButtonMinimumScaleFactor: CGFloat = 0.5
    }

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.layer.cornerRadius = Constants.defaultCornerRadius
        return imageView
    }()

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = UIFont.systemFont(ofSize: Constants.loginLabelSizeOfFont)
        label.numberOfLines = Constants.loginLabelNumberOfLines
        label.textColor = .black
        return label
    }()

    private lazy var summeryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = UIFont.systemFont(ofSize: Constants.summeryLabelSizeOfFont)
        label.numberOfLines = Constants.summeryLabelNumberOfLines
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, summeryLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = Constants.stackViewDistribution
        return stackView
    }()

    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(FindFriendsString.followButton.rawValue.localized, for: .normal)
        button.setTitle(FindFriendsString.unfollowButton.rawValue.localized, for: .selected)
        button.setTitleColor(.systemBackground, for: .normal)
        
        button.titleLabel?.font = .systemFont(ofSize: Constants.followButtonSizeOfFont)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = Constants.followButtonMinimumScaleFactor
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.defaultCornerRadius
        return button
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    func configureCell(with model: SearchFriendsModel) {
        profileImageView.image = model.image ?? UIImage.Icons.personPlaceholderIcon
        loginLabel.text = model.login
        configureSummeryLabel(text: model.summery)
        configureFollowButton(isFollowed: model.isFollowed ?? false)
    }
    
    private func configureSummeryLabel(text: String?) {
        summeryLabel.text = text
        summeryLabel.isHidden = text == nil
    }
    
    private func configureFollowButton(isFollowed: Bool) {
        followButton.isSelected = isFollowed
        followButton.backgroundColor = isFollowed ? Constants.followButtonSelectedColor : Constants.followButtonUnselectedColor
    }

    private func configureUI() {
        addSubview(profileImageView)
        addSubview(followButton)
        addSubview(informationStackView)
        
        layoutImageView()
        layoutFollowButton()
        layoutStackView()
    }

    // MARK: - Constraints

    private func layoutImageView() {
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offsetPicture).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offsetPictureFromLeft).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offsetPicture).isActive = true
    }

    private func layoutStackView() {
        informationStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.offset).isActive = true
        informationStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset).isActive = true
        informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset).isActive = true
        informationStackView.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -Constants.offset).isActive = true
    }

    private func layoutFollowButton() {
        followButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.multiplierWidthFollowButton).isActive = true
        followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offsetFollowButtonFromRight).isActive = true
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
