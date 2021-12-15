//
//  FindFriendCell.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

protocol SearchUsersCellDelegate: AnyObject {
    func didTapFollowButton(_ indexPath: Int?, completion: @escaping () -> ())
}

final class SearchUsersCell: UITableViewCell {
    // MARK: - Private Properties

    private struct Constants {
        static let offset: CGFloat = 8
        static let offsetPicture: CGFloat = 16
        static let offsetPictureFromLeft: CGFloat = 10
        static let offsetFollowButtonFromRight: CGFloat = 12
        static let multiplierWidthFollowButton: CGFloat = 0.21
        static let defaultCornerRadius: CGFloat = 12
        static let loginLabelSizeOfFont: CGFloat = 18
        static let summeryLabelSizeOfFont: CGFloat = 14
        static let stackViewSpacing: CGFloat = -20
        static let followButtonSizeOfFont: CGFloat = 15
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.loginLabelSizeOfFont)
        return label
    }()

    private lazy var summeryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.summeryLabelSizeOfFont)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, summeryLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle(FindUsersStrings.followButton.rawValue.localized, for: .normal)
        button.setTitle(FindUsersStrings.unfollowButton.rawValue.localized, for: .selected)
        button.setTitleColor(.AppColors.navigationTextColor, for: .normal)

        button.titleLabel?.font = .systemFont(ofSize: Constants.followButtonSizeOfFont)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5

        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.defaultCornerRadius
        button.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        return button
    }()
    
    var indexPathRow: Int?
    
    weak var delegate: SearchUsersCellDelegate?

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    
    func configureCell(with model: UserModel) {
        loginLabel.text = model.username
        configureSummeryLabel(text: model.summary)
        configureFollowButton(isFollowed: model.isFollowed ?? false)
        profileImageView.layoutIfNeeded()
        profileImageView.setImageForName(model.name ?? model.username, circular: false, textAttributes: nil)
    }
    
    func configureImage(image: UIImage?) {
        guard let image = image else {
            return
        }
        profileImageView.image = image
    }
    
    private func configureSummeryLabel(text: String?) {
        summeryLabel.text = text
        summeryLabel.isHidden = text == nil
    }
    
    private func configureFollowButton(isFollowed: Bool) {
        followButton.isSelected = isFollowed
        followButton.backgroundColor = isFollowed ? .AppColors.greyColor : .AppColors.accentColor
    }

    private func configureUI() {
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        
        layoutImageView()
        layoutFollowButton()
        layoutStackView()
    }

    // MARK: - Constraints

    private func layoutImageView() {
        addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offsetPicture).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offsetPictureFromLeft).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offsetPicture).isActive = true
    }

    private func layoutStackView() {
        addSubview(informationStackView)
        informationStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.offset).isActive = true
        informationStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset).isActive = true
        informationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset).isActive = true
        informationStackView.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -Constants.offset).isActive = true
    }

    private func layoutFollowButton() {
        addSubview(followButton)
        followButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.multiplierWidthFollowButton).isActive = true
        followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offsetFollowButtonFromRight).isActive = true
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func switchFollowButtonAnimated() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.configureFollowButton(isFollowed: !self.followButton.isSelected)
            self.followButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.followButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapFollowButton() {
        delegate?.didTapFollowButton(indexPathRow, completion: switchFollowButtonAnimated)
    }
}
