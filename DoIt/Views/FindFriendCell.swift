//
//  FindFriendCell.swift
//  DoIt
//
//  Created by Шестаков Никита on 24.10.2021.
//

import UIKit

final class FindFriendCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let offsetForPicture: CGFloat = 24 // to struct
    
    private lazy var profileImageView = ProfileImageView(cornerRadius: (SearchFriendsTableViewController.cellHeight - offsetForPicture * 2) / 2)
    
    private lazy var loginLabel: FriendShortInformationLabel = FriendShortInformationLabel.getLoginInformationLabel()
    
    private lazy var descriptionLabel: FriendShortInformationLabel = FriendShortInformationLabel.getDescriptionInformationLabel()
    
    private lazy var stackViewDescription = FriendShortInformationStackView(arrangedSubviews: [loginLabel, descriptionLabel],
                                                                            spacing: -20, // to constants
                                                                            distribution: .fillEqually)
    
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
        createAndActivateConstraintsForImageView()
        
        addSubview(followButton)
        createAndActivateConstraintsForFollowButton()
        
        addSubview(stackViewDescription)
        createAndActivateConstraintsForStackView()
    }
    
    // MARK: - Constraints
    
    private func createAndActivateConstraintsForImageView() {
        var constraints = [NSLayoutConstraint]()
        let offsetFromLeft: CGFloat = 8
        
        constraints.append(profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: offsetForPicture))
        constraints.append(profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offsetFromLeft))
        constraints.append(profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offsetForPicture))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createAndActivateConstraintsForStackView() {
        var constraints = [NSLayoutConstraint]()
        let offset: CGFloat = 8
        
        constraints.append(stackViewDescription.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: offset))
        constraints.append(stackViewDescription.topAnchor.constraint(equalTo: topAnchor, constant: offset))
        constraints.append(stackViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset))
        constraints.append(stackViewDescription.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -offset))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createAndActivateConstraintsForFollowButton() {
        var constraints = [NSLayoutConstraint]()
        let offset: CGFloat = 12
        let widthProportionally: CGFloat = 0.17
        
        constraints.append(followButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthProportionally))
        constraints.append(followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offset))
        constraints.append(followButton.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}
