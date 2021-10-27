//
//  CustomUIElementsSearchFriends.swift
//  DoIt
//
//  Created by Шестаков Никита on 25.10.2021.
//

import UIKit

final class ProfileImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(placeHolder: UIImage = UIImage.Icons.personPlaceholderIcon, cornerRadius: CGFloat = 8) {
        super.init(frame: .zero)
        
        setup(placeHolder: placeHolder, cornerRadius: cornerRadius)
    }

    private func setup(placeHolder: UIImage = UIImage.Icons.personPlaceholderIcon, cornerRadius: CGFloat = 8) {
        image = placeHolder
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}

final class FriendShortInformationLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(sizeOfFont: CGFloat = 16, textColor: UIColor = .systemGray, numberOfLines: Int = 0) {
        super.init(frame: .zero)

        setup(sizeOfFont: sizeOfFont, textColor: textColor, numberOfLines: numberOfLines)
    }
    
    static func getLoginInformationLabel() -> FriendShortInformationLabel {
        return FriendShortInformationLabel(sizeOfFont: UILabel.LoginDefaultSetup.fontSize,
                                           textColor: UILabel.LoginDefaultSetup.textColor,
                                           numberOfLines: UILabel.LoginDefaultSetup.numberOfLines)
    }

    static func getDescriptionInformationLabel() -> FriendShortInformationLabel {
        return FriendShortInformationLabel(sizeOfFont: UILabel.DescriptionDefaultSetup.fontSize,
                                           textColor: UILabel.DescriptionDefaultSetup.textColor,
                                           numberOfLines: UILabel.DescriptionDefaultSetup.numberOfLines)
    }

    private func setup(sizeOfFont: CGFloat = 16, textColor: UIColor = .systemGray, numberOfLines: Int = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.systemFont(ofSize: sizeOfFont)
        self.numberOfLines = numberOfLines
        self.textColor = textColor
    }
}

final class FriendShortInformationStackView: UIStackView {
    private var savedArrangedSubviews: [UIView?] = []

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(arrangedSubviews: [UIView?] = [], axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, distribution: Distribution = .fill, alignment: Alignment = .fill) {

        savedArrangedSubviews = arrangedSubviews

        super.init(frame: .zero)

        setup(axis: axis, spacing: spacing, distribution: distribution, alignment: alignment)
    }

    func updateSubviews() {
        savedArrangedSubviews.forEach { subview in
            guard let subview = subview as? UILabel else { return }
            addArrangedSubview(subview)
        }
    }

    override func addArrangedSubview(_ view: UIView) {
        super.addArrangedSubview(view)
        
        savedArrangedSubviews.append(view)
    }

    override func removeArrangedSubview(_ view: UIView) {
        super.removeArrangedSubview(view)

        for (index, subview) in savedArrangedSubviews.enumerated() {
            if subview == view {
                savedArrangedSubviews.remove(at: index)
                break
            }
        }
    }

    private func setup(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = 0, distribution: Distribution = .fill, alignment: Alignment = .fill) {

        updateSubviews()
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
}


final class FollowButton: UIButton {
    enum Constants: String {
        case Add, Remove
    }

    override var isSelected: Bool {
        didSet {
            guard !isSelected else { backgroundColor = .systemTeal; return }
            backgroundColor = .green
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setup()
    }

    init(cornerRadius: CGFloat = 8, backgroundColor: UIColor = .systemTeal, fontSize: CGFloat = 14) {
        super.init(frame: .zero)

        setup(cornerRadius: cornerRadius, backgroundColor: backgroundColor, fontSize: fontSize)
    }

    private func setup(cornerRadius: CGFloat = 8, backgroundColor: UIColor = .systemTeal, fontSize: CGFloat = 14,
                       target: Any? = nil, action: Selector? = nil) {
        translatesAutoresizingMaskIntoConstraints = false

        setTitle(Constants.Add.rawValue, for: .normal)
        setTitle(Constants.Remove.rawValue, for: .selected)
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

final class BackBarButtom: UIBarButtonItem {
    override init() {
        super.init()

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(width: CGFloat = 40, height: CGFloat = 40) {
        super.init()

        setup(width: width, height: height)
    }

    private func setup(width: CGFloat = 40, height: CGFloat = 40) {
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
        navBarAppearance.backgroundColor = .systemTeal
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

extension UIImage {
    struct Icons {
        static let personPlaceholderIcon = UIImage(named: "imagePlaceHolder")!
        static let arrowBackButtonIcon = UIImage(systemName: "arrow.left")!
    }
}

extension UILabel {
    struct LoginDefaultSetup {
        static let fontSize: CGFloat = 18
        static let textColor: UIColor = .black
        static let numberOfLines: Int = 1
    }

    struct DescriptionDefaultSetup {
        static let fontSize: CGFloat = 16
        static let textColor: UIColor = .systemGray
        static let numberOfLines: Int = 0
    }
}
