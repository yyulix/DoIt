//
//  CustomUIElementsProfile.swift
//  DoIt
//
//  Created by Шестаков Никита on 03.11.2021.
//

import Foundation
import UIKit

extension UIView {
    func setShadows() {
        struct Constants {
            static let shadowOpacity: Float = 0.65
            static let shadowRadius: CGFloat = 5
            static let shadowColor: CGColor = UIColor.lightGray.cgColor
        }
        
        layer.shadowColor = Constants.shadowColor
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = Constants.shadowRadius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}

final class ProfileHeaderView: UIView {
    override var bounds: CGRect {
        didSet {
            setShadows()
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 8
        static let defaultOffset: CGFloat = 8
        static let spacing: CGFloat = 4
        static let backgroundColor: UIColor = .systemGray6
        static let sizeOfFont: CGFloat = 14
        static let textColor: UIColor = .black
        static let numberOfLines: Int = 1
        static let differenceBetweenFontSize: CGFloat = 2
    }
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: FriendShortInformationLabel = {
        let label = FriendShortInformationLabel(sizeOfFont: Constants.sizeOfFont, textColor: Constants.textColor, numberOfLines: Constants.numberOfLines)
        label.text = "Nikita Shestakov"
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var loginLabel: FriendShortInformationLabel = {
        let label = FriendShortInformationLabel(sizeOfFont: Constants.sizeOfFont - Constants.differenceBetweenFontSize, textColor: Constants.textColor, numberOfLines: Constants.numberOfLines)
        label.text = "@rikine"
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    init(height: CGFloat) {
        super.init(frame: .zero)
        
        setup(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(height: CGFloat) {
        configureHeader()
        constraintsForView(height: height)
        
        addSubview(profileImageView)
        addSubview(loginLabel)
        addSubview(nameLabel)
        
        constraintsForLoginLabel()
        constraintsForProfileImageView()
        constraintsForNameLabel()
    }
    
    private func configureHeader() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        setShadows()
    }
    
    private func constraintsForView(height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func constraintsForProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultOffset).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -Constants.spacing).isActive = true
    }
    
    private func constraintsForNameLabel() {
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.defaultOffset).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.defaultOffset).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: loginLabel.topAnchor, constant: -Constants.spacing).isActive = true
    }
    
    private func constraintsForLoginLabel() {
        loginLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.defaultOffset).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.defaultOffset).isActive = true
        loginLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultOffset).isActive = true
    }
}

final class ProfileInformationCell: UIView {
    override var bounds: CGRect {
        didSet {
            setShadows()
        }
    }
    
    struct Constants {
        static let sizeOfFont: CGFloat = 14
        static let textColor: UIColor = .black
        static let numberOfLinesForTitle: Int = 1
        static let numberOfLines: Int = 0
        static let backgroundColor: UIColor = .systemGray6
        static let cornerRadius: CGFloat = 8
        static let defaultOffset: CGFloat = 8
        static let spacing: CGFloat = 4
    }
    
    private lazy var titleLabel: FriendShortInformationLabel = {
        let label = FriendShortInformationLabel(sizeOfFont: Constants.sizeOfFont, textColor: Constants.textColor, numberOfLines: Constants.numberOfLinesForTitle)
        label.text = "Summary:"
        return label
    }()
    
    private lazy var textLabel: FriendShortInformationLabel = {
        let label = FriendShortInformationLabel(sizeOfFont: Constants.sizeOfFont, textColor: Constants.textColor, numberOfLines: Constants.numberOfLines)
        label.text = "Lorem impasym gsdfgfdahg hsd hgsd hgfs sfghgs dfh sfg nn gdxn gsf njsff gjf jgdsf j bfsi ong fsbfdjsb sfido fdb foidgs bgjs bo bjksndf ib naob dfsobnsn bofni if biofs bsf bosirnbs btios bio sbio soienr bfkg nbiosnd boains biono snbio nsioboen"
        return label
    }()
    
    init(title: String?) {
        super.init(frame: .zero)
        
        setup(title: title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup(title: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(title: String?) {
        configureCell()
        addSubview(titleLabel)
        configureTitle(title: title)
        addSubview(textLabel)
        constraintsForTextLabel()
        constraintsForTitleLabel()
    }
    
    private func configureCell() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        setShadows()
    }
    
    private func configureTitle(title: String?) {
        titleLabel.text = title
    }
    
    private func constraintsForTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.defaultOffset).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.defaultOffset).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.defaultOffset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -Constants.spacing).isActive = true
    }
    
    private func constraintsForTextLabel() {
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.defaultOffset).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.defaultOffset).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.defaultOffset).isActive = true
    }
    
    func setText(text: String?) {
        textLabel.text = text
    }
}

//final class ProfileView: UIView {
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = ProfileViewController.Constants.backgroundColor
//        return scrollView
//    }()
//
//    private let headerView: ProfileHeaderView
//
//    private let cellsStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.axis = .vertical
//        return stack
//    }()
//
//    private lazy var summaryCell1 = ProfileInformationCell(title: "Summary")
//    private lazy var summaryCell2 = ProfileInformationCell(title: "Summary")
//    private lazy var summaryCell3 = ProfileInformationCell(title: "Summary")
//    private lazy var summaryCell4 = ProfileInformationCell(title: "Summary")
//    private lazy var summaryCell5 = ProfileInformationCell(title: "Summary")
//    private lazy var summaryCell6 = ProfileInformationCell(title: "Summary")
//
//    init(headerHeight: CGFloat) {
//        headerView = ProfileHeaderView(height: headerHeight)
//
//        super.init(frame: .zero)
//
//        setup()
//    }
//
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setup() {
//        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = ProfileViewController.Constants.backgroundColor
//
//        addSubview(scrollView)
//        scrollView.addSubview(headerView)
//        scrollView.addSubview(cellsStackView)
//        cellsStackView.addArrangedSubview(summaryCell1)
//        cellsStackView.addArrangedSubview(summaryCell2)
//        cellsStackView.addArrangedSubview(summaryCell3)
//        cellsStackView.addArrangedSubview(summaryCell4)
//        cellsStackView.addArrangedSubview(summaryCell5)
//        cellsStackView.addArrangedSubview(summaryCell6)
//        constraingsForScrollView()
//        constraintsForHeaderView()
//        constraintsForCellsStackView()
//    }
//
//    private func constraingsForScrollView() {
//        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//    }
//
//    private func constraintsForHeaderView() {
//        headerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        headerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
//        headerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//        headerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//    }
//
//    private func constraintsForCellsStackView() {
//        cellsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8).isActive = true
//        cellsStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
//        cellsStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//    }
//}

protocol NavigationControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

final class ProfileView: UIView {
    struct Constants {
        static let defaultOffset: CGFloat = 8
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = ProfileViewController.Constants.backgroundColor
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    var delegate: NavigationControllerDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ProfileViewController.Constants.backgroundColor
        return view
    }()

    private let headerView: ProfileHeaderView

    private let cellsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    private lazy var summaryCell1 = ProfileInformationCell(title: "Summary")
    private lazy var summaryCell2 = ProfileInformationCell(title: "Summary")
    private lazy var summaryCell3 = ProfileInformationCell(title: "Summary")
    private lazy var summaryCell4 = ProfileInformationCell(title: "Summary")
    private lazy var summaryCell5 = ProfileInformationCell(title: "Summary")
    private lazy var summaryCell6 = ProfileInformationCell(title: "Summary")

    init(headerHeight: CGFloat) {
        headerView = ProfileHeaderView(height: headerHeight)

        super.init(frame: .zero)

        setup()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ProfileViewController.Constants.backgroundColor

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(cellsStackView)
        cellsStackView.addArrangedSubview(summaryCell1)
        cellsStackView.addArrangedSubview(summaryCell2)
        cellsStackView.addArrangedSubview(summaryCell3)
        cellsStackView.addArrangedSubview(summaryCell4)
        cellsStackView.addArrangedSubview(summaryCell5)
        cellsStackView.addArrangedSubview(summaryCell6)
        constraingsForScrollView()
        constraingsForContentView()
        constraintsForHeaderView()
        constraintsForCellsStackView()
    }

    private func constraingsForScrollView() {
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func constraingsForContentView() {
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    private func constraintsForHeaderView() {
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultOffset).isActive = true
        headerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.defaultOffset).isActive = true
        headerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.defaultOffset).isActive = true
//        headerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    private func constraintsForCellsStackView() {
        cellsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.defaultOffset).isActive = true
        cellsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.defaultOffset).isActive = true
        cellsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.defaultOffset).isActive = true
        cellsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.defaultOffset).isActive = true
    }
}

extension ProfileView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}
