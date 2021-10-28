//
//  CustomUIElementsSearchFriends.swift
//  DoIt
//
//  Created by Шестаков Никита on 25.10.2021.
//

import UIKit

final class ProfileImageView: UIImageView {
    struct Constants {
        static let cornerRadius: CGFloat = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup(placeHolder: UIImage.Icons.personPlaceholderIcon, cornerRadius: Constants.cornerRadius)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeHolder: UIImage = UIImage.Icons.personPlaceholderIcon, cornerRadius: CGFloat = Constants.cornerRadius) {
        super.init(frame: .zero)
        
        setup(placeHolder: placeHolder, cornerRadius: cornerRadius)
    }

    private func setup(placeHolder: UIImage, cornerRadius: CGFloat) {
        image = placeHolder
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
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
        static let fontSize: CGFloat = 14
        static let selectedBackgroundColor: UIColor = .green
    }
    
    enum TextConstants: String {
        case Add, Remove
    }

    override var isSelected: Bool {
        didSet {
            guard !isSelected else { backgroundColor = .AppColors.accentColor; return }
            backgroundColor = Constants.selectedBackgroundColor
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

        setTitle(TextConstants.Add.rawValue, for: .normal)
        setTitle(TextConstants.Remove.rawValue, for: .selected)
        setTitleColor(.systemBackground, for: .normal)

        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor

        
        if let target = target, let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }
}

final class BackBarButtom: UIBarButtonItem {
    struct Constants {
        static let width: CGFloat = 40
        static let height: CGFloat = 40
    }
    
    override init() {
        super.init()

        setup(width: Constants.width, height: Constants.height)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(width: CGFloat = Constants.width, height: CGFloat = Constants.height) {
        super.init()

        setup(width: width, height: height)
    }

    private func setup(width: CGFloat, height: CGFloat) {
        let backButton = UIButton()
        backButton.frame.size = .init(width: width, height: height)
        backButton.setImage(UIImage.Icons.arrowBackButtonIcon, for: .normal)
        customView = backButton
    }
}

final class CustomNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        setupNavigationBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .AppColors.accentColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
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

extension UIColor {
    struct AppColors {
        static let accentColor = UIColor.systemTeal
    }
}

extension UIImage {
    struct Icons {
        static let personPlaceholderIcon = UIImage(named: "imagePlaceHolder")!
        static let arrowBackButtonIcon = UIImage(systemName: "arrow.left")!
    }
}