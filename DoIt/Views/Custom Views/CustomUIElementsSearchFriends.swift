//
//  CustomUIElementsSearchFriends.swift
//  DoIt
//
//  Created by Шестаков Никита on 25.10.2021.
//

import UIKit

final class ProfileCircledImageView: UIImageView {
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.size.width / 2
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup(placeHolder: UIImage.AuthIcons.personIcon)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeHolder: UIImage = UIImage.AuthIcons.personIcon) {
        super.init(frame: .zero)
        
        setup(placeHolder: placeHolder)
    }

    private func setup(placeHolder: UIImage) {
        image = placeHolder
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
        widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}

final class FriendShortInformationLabel: UILabel {
    override var text: String? {
        didSet {
            guard let _ = text else { isHidden = true; return }
            isHidden = false
        }
    }

    struct Constants {
        static let sizeOfFont: CGFloat = 16
        static let textColor: UIColor = .black
        static let numberOfLines: Int = 1
    }

    private struct LoginDefaultSetupConstants {
        static let fontSize: CGFloat = 18
        static let textColor: UIColor = .black
        static let numberOfLines: Int = 1
    }

    private struct DescriptionDefaultSetupConstants {
        static let fontSize: CGFloat = 16
        static let textColor: UIColor = .systemGray
        static let numberOfLines: Int = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup(sizeOfFont: Constants.sizeOfFont, textColor: Constants.textColor, numberOfLines: Constants.numberOfLines)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(sizeOfFont: CGFloat = Constants.sizeOfFont, textColor: UIColor = Constants.textColor, numberOfLines: Int = Constants.numberOfLines) {
        super.init(frame: .zero)

        setup(sizeOfFont: sizeOfFont, textColor: textColor, numberOfLines: numberOfLines)
    }
    
    static func getLoginInformationLabel() -> FriendShortInformationLabel {
        return FriendShortInformationLabel(sizeOfFont: LoginDefaultSetupConstants.fontSize,
                                           textColor: LoginDefaultSetupConstants.textColor,
                                           numberOfLines: LoginDefaultSetupConstants.numberOfLines)
    }

    static func getDescriptionInformationLabel() -> FriendShortInformationLabel {
        return FriendShortInformationLabel(sizeOfFont: DescriptionDefaultSetupConstants.fontSize,
                                           textColor: DescriptionDefaultSetupConstants.textColor,
                                           numberOfLines: DescriptionDefaultSetupConstants.numberOfLines)
    }

    private func setup(sizeOfFont: CGFloat, textColor: UIColor, numberOfLines: Int) {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: sizeOfFont)
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        isHidden = true
    }
}

final class FriendShortInformationStackView: UIStackView { // TODO
    struct Constants {
        static let axis: NSLayoutConstraint.Axis = .vertical
        static let spacing: CGFloat = 0
        static let distribution: Distribution = .fill
        static let aligment: Alignment = .fill
    }

    init(arrangedSubviews: [UIView] = [], axis: NSLayoutConstraint.Axis = Constants.axis, spacing: CGFloat = Constants.spacing, distribution: Distribution = Constants.distribution, alignment: Alignment = Constants.aligment) {
        super.init(frame: .zero)

        setup(arrangedSubviews: arrangedSubviews, axis: axis, spacing: spacing, distribution: distribution, alignment: alignment)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: Distribution, alignment: Alignment) {
        arrangedSubviews.forEach({addArrangedSubview($0)})
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
}

final class FollowButton: UIButton {
    struct Constants {
        static let cornerRadius: CGFloat = 8
        static let fontSize: CGFloat = 15
        static let selectedBackgroundColor: UIColor = .green
    }

    override var isSelected: Bool {
        didSet {
            guard !isSelected else { backgroundColor = .AppColors.accentColor; return }
            backgroundColor =  Constants.selectedBackgroundColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup(cornerRadius: Constants.cornerRadius, backgroundColor: .AppColors.accentColor, fontSize: Constants.fontSize, target: nil, action: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup(cornerRadius: Constants.cornerRadius, backgroundColor: .AppColors.accentColor, fontSize: Constants.fontSize, target: nil, action: nil)
    }

    init(cornerRadius: CGFloat = Constants.cornerRadius, backgroundColor: UIColor = .AppColors.accentColor, fontSize: CGFloat = Constants.fontSize, target: Any? = nil, action: Selector? = nil) {
        super.init(frame: .zero)

        setup(cornerRadius: cornerRadius, backgroundColor: backgroundColor, fontSize: fontSize, target: target, action: action)
    }

    private func setup(cornerRadius: CGFloat, backgroundColor: UIColor, fontSize: CGFloat, target: Any?, action: Selector?) {
        translatesAutoresizingMaskIntoConstraints = false

        setTitle(FindFriendsString.followButton.rawValue.localized, for: .normal)
        setTitle(FindFriendsString.unfollowButton.rawValue.localized, for: .selected)
        setTitleColor(.systemBackground, for: .normal)

        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        
        titleLabel?.font = .systemFont(ofSize: fontSize)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5

        
        if let target = target, let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

final class CustomSearchController: UISearchController {
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeholder: String? = nil) {
        super.init(searchResultsController: nil)

        setup(placeholder: placeholder)
    }

    private func setup(placeholder: String? = nil) {
        obscuresBackgroundDuringPresentation = false
        searchBar.tintColor = .white
        searchBar.searchTextField.tintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.placeholder = placeholder
    }
}
