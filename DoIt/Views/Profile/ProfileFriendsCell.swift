//
//  FriendsCell.swift
//  DoIt
//
//  Created by Шестаков Никита on 20.11.2021.
//

import Foundation
import UIKit

class ProfileFriendsCell: UICollectionViewCell {
    // MARK: - Private Properties

    private struct Constants {
        static let offset: CGFloat = 4
        static let profileImageCornerRadius: CGFloat = 12
        static let loginLabelSizeOfFont: CGFloat = 14
        static let imageOffset: CGFloat = 15
    }
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Constants.profileImageCornerRadius
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.loginLabelSizeOfFont)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureCell(with: ProfileFriendsModel) {
        loginLabel.text = "@" + with.login
        guard let image = with.image else {
            profileImageView.layoutIfNeeded()
            profileImageView.setImageForName(with.name ?? with.login, circular: false, textAttributes: nil)
            return
        }
        profileImageView.image = image
    }
    
    private func configureUI() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = false
        
        layoutContentView()
        layoutImageView()
        layoutLoginLabel()
    }

    // MARK: - Constraints
    
    private func layoutContentView() {
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func layoutImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.imageOffset).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.imageOffset).isActive = true
    }

    private func layoutLoginLabel() {
        contentView.addSubview(loginLabel)
        loginLabel.topAnchor.constraint(lessThanOrEqualTo: profileImageView.bottomAnchor, constant: Constants.offset).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        loginLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
