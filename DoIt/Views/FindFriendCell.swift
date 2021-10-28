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
        static let offsetForPicture: CGFloat = 24
        static let defaultOffset: CGFloat = 8
        static let offsetForFollowButtonFromRight: CGFloat = 12
        static let spacingInStackView: CGFloat = -20
        static let widthProportionallyForFollowButton: CGFloat = 0.17
        static let distributionInStackView: UIStackView.Distribution = .fillEqually
    }

    private lazy var profileImageView = ProfileImageView(cornerRadius: (SearchFriendsTableViewController.Constants.cellHeight - Constants.offsetForPicture * 2) / 2)

    private lazy var loginLabel: FriendShortInformationLabel = FriendShortInformationLabel.getLoginInformationLabel()

    private lazy var descriptionLabel: FriendShortInformationLabel = FriendShortInformationLabel.getDescriptionInformationLabel()

    private lazy var stackViewDescription = FriendShortInformationStackView(arrangedSubviews: [loginLabel, descriptionLabel],
                                                                            spacing: Constants.spacingInStackView,
                                                                            distribution: Constants.distributionInStackView)

    private lazy var followButton = FollowButton()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    private func configureUI() {
        addSubview(profileImageView)
        constraintsForImageView()

        addSubview(followButton)
        constraintsForFollowButton()

        addSubview(stackViewDescription)
        constraintsForStackView()
    }

    // MARK: - Constraints

    private func constraintsForImageView() {
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offsetForPicture).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.defaultOffset).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offsetForPicture).isActive = true
    }

    private func constraintsForStackView() {
        stackViewDescription.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.defaultOffset).isActive = true
        stackViewDescription.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultOffset).isActive = true
        stackViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultOffset).isActive = true
        stackViewDescription.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -Constants.defaultOffset).isActive = true
    }

    private func constraintsForFollowButton() {
        followButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.widthProportionallyForFollowButton).isActive = true
        followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offsetForFollowButtonFromRight).isActive = true
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
