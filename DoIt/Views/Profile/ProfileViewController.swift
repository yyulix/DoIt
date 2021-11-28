//
//  ProfileViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 02.11.2021.
//

import UIKit
import InitialsImageView

class ProfileViewController: UIViewController {
    // MARK: - Properties
    
    struct Constants {
        // Collection View
        static let collectionViewCellSize: CGSize = .init(width: 120, height: 120)
        static let collectionViewInset: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        static let offset: CGFloat = 8
        static let spacingStackView: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        
        // Header
        static let headerHeight: CGFloat = 210
        static let headerHeightWithName: CGFloat = 230
        static let myHeaderHeight: CGFloat = 180
        static let myHeaderHeightWithName: CGFloat = 200
        
        static let headerCornerRadius: CGFloat = 8
        
        static let nameLabelSizeOfFont: CGFloat = 16
        
        static let loginLabelSizeOfFont: CGFloat = 12
        
        static let followButtonSizeOfFont: CGFloat = 15
        static let followButtonWidth: CGFloat = 80
        static let followButtonHeight: CGFloat = 27
        
        static let stackViewLeftRightOffset: CGFloat = 24
        static let stackViewBottomOffset: CGFloat = offset * 2
        static let stackViewSpacingHeader: CGFloat = 12
        static let stackViewSpacingAfterName: CGFloat = -4
        
        static let contentViewTopOffset: CGFloat = 50
        static let contentViewCornerRadius: CGFloat = 20
        
        // Information
        static let titleLabelSizeOfFont: CGFloat = 12
        static let textLabelSizeOfFont: CGFloat = 14
        
        // Statistics
        static let textInformationSizeOfFont: CGFloat = 12
        static let numberSizeOfFont: CGFloat = 20
        static let stackViewSpacingBetweenStackViews: CGFloat = 2
        
        // Tasks
        static let tasksNumber: Int = 3
        static let tasksCornerRadius: CGFloat = 12
        static let tasksImageSize: CGFloat = 40
        static let tasksPaddingLeft: CGFloat = 13
        static let tasksTitleFontSize: CGFloat = 18
        static let tasksDividerWidth: CGFloat = 1
        static let tasksIndicatorWidth: CGFloat = 10
        
        // Friends
        static let friendsConllectionHeight: CGFloat = 120
        
        // Separator
        static let heightSeparator: CGFloat = 1
        static let offsetSeparator: CGFloat = 20
    }
    
    private lazy var settingButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.ProfileIcons.gearIcon, for: .normal)
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        button.tintColor = .AppColors.navigationTextColor
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView: UIView = getView()
    
    // MARK: - Header View
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Constants.cornerRadius
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.nameLabelSizeOfFont)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.loginLabelSizeOfFont)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setTitle(FindFriendsStrings.followButton.rawValue.localized, for: .normal)
        button.setTitle(FindFriendsStrings.unfollowButton.rawValue.localized, for: .selected)
        button.setTitleColor(.AppColors.navigationTextColor, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.followButtonSizeOfFont)

        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.setContentCompressionResistancePriority(.required, for: .vertical)
        button.widthAnchor.constraint(equalToConstant: Constants.followButtonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.followButtonHeight).isActive = true
        button.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private var headerHeightConstraint: NSLayoutConstraint = .init()
    
    // MARK: - Information View
    
    private lazy var titleLabelInformation: UILabel = getTitleLabel(title: ProfileStrings.titleSummary.rawValue.localized)
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.textLabelSizeOfFont)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Statistics View
    
    private lazy var titleLabelStatistics: UILabel = getTitleLabel(title: ProfileStrings.titleStatistics.rawValue.localized)
    
    private lazy var inProgressTextLabel: UILabel = getLabelForStatistics(title: ProfileStrings.statisticsInProgress.rawValue.localized)
    private lazy var inProgressNumberLabel: UILabel = getLabelForStatistics()
    
    private lazy var outdatedTextLabel: UILabel = getLabelForStatistics(title: ProfileStrings.statisticsExpired.rawValue.localized)
    private lazy var outdatedNumberLabel: UILabel = getLabelForStatistics()
    
    private lazy var doneTextLabel: UILabel = getLabelForStatistics(title: ProfileStrings.statisticsDone.rawValue.localized)
    private lazy var doneNumberLabel: UILabel = getLabelForStatistics()
    
    private lazy var totalTextLabel: UILabel = getLabelForStatistics(title: ProfileStrings.statisticsTotal.rawValue.localized)
    private lazy var totalNumberLabel: UILabel = getLabelForStatistics()
    
    // MARK: - Task View
    
    private lazy var titleLabelTasks: UILabel = getTitleLabel(title: ProfileStrings.titleTasks.rawValue.localized)
    
    private lazy var noTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.textLabelSizeOfFont)
        label.text = ProfileStrings.noTasks.rawValue.localized
        return label
    }()
    
    private lazy var showAllTasksButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .AppColors.accentColor
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(showAllTasks), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    private lazy var taskViews: [UIView] = []
    private lazy var chapterTaskIndicatorViews: [UIView] = []
    private lazy var titleTaskLabels: [UILabel] = []
    private lazy var imageTaskViews: [UIImageView] = []
    private lazy var descriptionTaskLabels: [UILabel] = []
    private lazy var deadlineTaskLabels: [UILabel] = []
    private lazy var dividerTaskViews: [UIView] = []
    
    // MARK: - Friends View
    
    private lazy var titleLabelFriends: UILabel = getTitleLabel(title: ProfileStrings.titleFriends.rawValue.localized)
    
    private lazy var noFriendsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.textLabelSizeOfFont)
        label.text = ProfileStrings.noFriends.rawValue.localized
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Constants.collectionViewCellSize
        
        layout.sectionInset = Constants.collectionViewInset
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ProfileFriendsCell.self, forCellWithReuseIdentifier: String(describing: ProfileFriendsCell.self))
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    // MARK: - Configuration
    
    private var information: ProfileModel = ProfileModel(
        image: nil,
        name: nil,
        login: "",
        summary: nil,
        statistics: .init(inProgress: "0", outdated: "0", done: "0", total: "0"),
        tasks: nil,
        friends: [],
        isMyScreen: false,
        isFollowed: false)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configure()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationController(title: ProfileStrings.header.rawValue.localized)
        layoutScrollView()
        layoutContentView()
        layoutCellsStackView()
    }
    
    private func configure() {
        information = ProfileModel(
            image: nil,
            name: nil,
            login: "",
            summary: nil,
            statistics: ProfileStatisticsModel(inProgress: "0", outdated: "0", done: "0", total: "0"),
            tasks: nil,
            friends: nil,
            isMyScreen: true,
            isFollowed: false)
        
        configureNavigationController(title: information.login, isMyScreen: information.isMyScreen)
        configureCells()
    }
    
    private func configureCells() {
        configureHeader(image: information.image, name: information.name, login: information.login, isFollowed: information.isFollowed, isMyScreen: information.isMyScreen)
        configureInformation(summary: information.summary)
        configureStatistics(with: information.statistics)
        configureTasks(with: information.tasks ?? [])
        
        if let friends = information.friends {
            configureFriends(isFriendsEmpty: friends.count == 0 ? true : false)
        } else {
            configureFriends(isFriendsEmpty: true)
        }
    }
}

// MARK: - Main Constraints

extension ProfileViewController {
    private func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func layoutContentView() {
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func layoutCellsStackView() {
        let allViews = [configureHeaderView(), configureInformationView(), getSeparatorView(), configureStatisticsView(), getSeparatorView(), configureTasksView(), getSeparatorView(), configureFriendsView(), getSeparatorView()]
        configureStackView(arrangedSubviews: allViews, spacing: Constants.spacingStackView, toView: contentView)
    }
}

// MARK: - Header View Configuration

extension ProfileViewController {
    private func configureHeader(image: UIImage?, name: String?, login: String, isFollowed: Bool, isMyScreen: Bool) {
        configureHeaderHeight(withName: name != nil, isMyScreen: isMyScreen)
        configureProfileImage(image: image, name: name, login: login)
        
        nameLabel.text = name
        loginLabel.text = "@" + login
        
        configureFollowButton(isFollowed: isFollowed)
        followButton.isHidden = isMyScreen
    }
    
    private func configureHeaderView() -> UIView {
        let view = getView()
        view.layer.cornerRadius = Constants.headerCornerRadius
        view.layer.zPosition = -2
        headerHeightConstraint = view.heightAnchor.constraint(equalToConstant: Constants.myHeaderHeight)
        headerHeightConstraint.isActive = true
        
        let stack = configureHeaderStackView()
        layoutHeaderStackView(stackView: stack, toView: view)
        layoutHeaderInnerView(stackView: stack, toView: view)
        configureFollowButton(isFollowed: false)
        return view
    }
    
    private func layoutHeaderStackView(stackView stack: UIStackView, toView: UIView) {
        toView.addSubview(stack)
        stack.topAnchor.constraint(equalTo: toView.topAnchor, constant: Constants.offset).isActive = true
        stack.leftAnchor.constraint(equalTo: toView.leftAnchor, constant: Constants.stackViewLeftRightOffset).isActive = true
        stack.rightAnchor.constraint(equalTo: toView.rightAnchor, constant: -Constants.stackViewLeftRightOffset).isActive = true
        stack.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -Constants.stackViewBottomOffset).isActive = true
    }
    
    private func layoutHeaderInnerView(stackView stack: UIStackView, toView: UIView) {
        let innerView = getView()
        innerView.backgroundColor = .ProfileColors.headerColor
        innerView.layer.zPosition = -1
        innerView.isUserInteractionEnabled = false
        innerView.layer.cornerRadius = Constants.contentViewCornerRadius
        innerView.layer.masksToBounds = true
        
        toView.addSubview(innerView)
        innerView.topAnchor.constraint(equalTo: toView.topAnchor, constant: Constants.contentViewTopOffset).isActive = true
        innerView.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: -Constants.offset).isActive = true
        innerView.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: Constants.offset).isActive = true
        innerView.bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
    }
    
    private func configureFollowButton(isFollowed: Bool) {
        followButton.isSelected = isFollowed
        followButton.backgroundColor = isFollowed ? .AppColors.grey : .AppColors.accentColor
    }
    
    private func configureHeaderHeight(withName: Bool, isMyScreen: Bool) {
        if withName {
            headerHeightConstraint.constant = isMyScreen ? Constants.myHeaderHeightWithName : Constants.headerHeightWithName
        } else {
            headerHeightConstraint.constant = isMyScreen ? Constants.myHeaderHeight : Constants.headerHeight
        }
    }
    
    private func configureProfileImage(image: UIImage?, name: String?, login: String) {
        profileImageView.layoutIfNeeded()
        guard let image = image else {
            profileImageView.setImageForName(name ?? login, circular: false, textAttributes: nil)
            return
        }
        profileImageView.image = image
    }
    
    @objc
    private func didTapFollowButton() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
            self.configureFollowButton(isFollowed: !self.followButton.isSelected)
            self.followButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.followButton.transform = CGAffineTransform.identity
            }
        }
    }
    
    private func configureHeaderStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, loginLabel, followButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.stackViewSpacingHeader
        stack.alignment = .center
        stack.setCustomSpacing(Constants.stackViewSpacingAfterName, after: nameLabel)
        return stack
    }
}

// MARK: - Information View Configuration

extension ProfileViewController {
    private func configureInformation(summary: String?) {
        summaryLabel.text = summary ?? ProfileStrings.summaryPlaceholder.rawValue.localized
    }
    
    private func configureInformationView() -> UIView {
        let view = getView()
        configureStackView(arrangedSubviews: [titleLabelInformation, summaryLabel], spacing: Constants.spacingStackView, toView: view)
        return view
    }
}

// MARK: - Statistics View Configuration

extension ProfileViewController {
    private func configureStatistics(with: ProfileStatisticsModel) {
        inProgressNumberLabel.text = with.inProgress
        outdatedNumberLabel.text = with.outdated
        doneNumberLabel.text = with.done
        totalNumberLabel.text = with.total
    }
    
    private func configureStatisticsView() -> UIView {
        let view = getView()
        configureStackView(arrangedSubviews: [titleLabelStatistics, layoutStackViewStatistics()], spacing: Constants.spacingStackView, toView: view)
        return view
    }
    
    private func layoutStackViewStatistics() -> UIStackView {
        let inProgressStack = getSubStackViewStatistics(titleLabel: inProgressTextLabel, numberLabel: inProgressNumberLabel)
        let outdatedStack = getSubStackViewStatistics(titleLabel: outdatedTextLabel, numberLabel: outdatedNumberLabel)
        let doneStack = getSubStackViewStatistics(titleLabel: doneTextLabel, numberLabel: doneNumberLabel)
        let totalStack = getSubStackViewStatistics(titleLabel: totalTextLabel, numberLabel: totalNumberLabel)
        
        let stack = UIStackView(arrangedSubviews: [inProgressStack, outdatedStack, doneStack, totalStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = Constants.stackViewSpacingBetweenStackViews
        return stack
    }
    
    private func getSubStackViewStatistics(titleLabel: UILabel, numberLabel: UILabel) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [numberLabel, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.spacingStackView
        return stack
    }
    
    private func getLabelForStatistics(title: String? = nil) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: title == nil ? Constants.numberSizeOfFont : Constants.textInformationSizeOfFont)
        label.text = title ?? "0"
        label.textAlignment = .center
        return label
    }
}

// MARK: - Tasks View Configuration

extension ProfileViewController {
    private func configureTasks(with: [ProfileTaskModel]) {
        let taskToConfigure = min(with.count, taskViews.count)
        for i in 0..<taskToConfigure {
            configureTaskView(index: i, with: with[i])
        }
        
        showTasks(count: taskToConfigure)
        noTasksLabel.isHidden = taskToConfigure != 0
        showAllTasksButton.isHidden = taskToConfigure == 0
    }
    
    private func configureTasksView() -> UIView {
        let view = getView()
        
        for _ in 0..<Constants.tasksNumber {
            createTaskView()
        }
        
        var arrangedSubviews: [UIView] = [getTasksSubStackView(arrangedSubviews: [titleLabelTasks, showAllTasksButton])]
        arrangedSubviews.append(contentsOf: taskViews)
        arrangedSubviews.append(noTasksLabel)
        
        taskViews.forEach {
            $0.isHidden = true
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTask(_:))))
        }
        
        configureStackView(arrangedSubviews: arrangedSubviews, spacing: Constants.spacingStackView, toView: view)
        return view
    }
    
    private func showTasks(count: Int) {
        for i in 0..<count {
            taskViews[i].isHidden = false
        }
        hideTasks(fromTaskIndex: count)
    }
    
    private func hideTasks(fromTaskIndex: Int) {
        for i in fromTaskIndex..<taskViews.count {
            taskViews[i].isHidden = true
        }
    }
    
    private func createTaskView() {
        let view = getView()
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.tasksCornerRadius
        view.contentMode = .scaleAspectFit
        
        let chapterIndicatorView = configureTaskChapterIndicatorView(rootView: view)
        let titleTaskLabel = getTaskLabel(fontSize: Constants.tasksTitleFontSize)
        let imageTaskView = getImageTaskView()
        let descriptionTaskLabel = getDescriptionTaskLabel()
        let deadlineTaskLabel = getTaskLabel(fontSize: Constants.textLabelSizeOfFont)
        let dividerTaskView = getDividerTaskView()
        
        taskViews.append(view)
        chapterTaskIndicatorViews.append(chapterIndicatorView)
        titleTaskLabels.append(titleTaskLabel)
        imageTaskViews.append(imageTaskView)
        descriptionTaskLabels.append(descriptionTaskLabel)
        deadlineTaskLabels.append(deadlineTaskLabel)
        dividerTaskViews.append(dividerTaskView)
        
        let arrangedSubview = [titleTaskLabel, getTasksSubStackView(arrangedSubviews: [imageTaskView, descriptionTaskLabel]), deadlineTaskLabel, dividerTaskView]
        layoutTasksMainStackView(rootView: view, chapterIndicatorView: chapterIndicatorView, arrangedSubviews: arrangedSubview)
    }
    
    private func layoutTasksMainStackView(rootView: UIView, chapterIndicatorView: UIView, arrangedSubviews: [UIView]) {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Constants.spacingStackView
        stack.axis = .vertical
        rootView.addSubview(stack)
        stack.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: chapterIndicatorView.rightAnchor, constant: Constants.tasksPaddingLeft).isActive = true
        stack.rightAnchor.constraint(equalTo: rootView.rightAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
    }
    
    private func getTasksSubStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = Constants.spacingStackView
        return stack
    }
    
    private func configureTaskChapterIndicatorView(rootView: UIView) -> UIView {
        let chapterIndicatorView = getView()
        rootView.addSubview(chapterIndicatorView)
        chapterIndicatorView.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        chapterIndicatorView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor).isActive = true
        chapterIndicatorView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
        chapterIndicatorView.widthAnchor.constraint(equalToConstant: Constants.tasksIndicatorWidth).isActive = true
        return chapterIndicatorView
    }
    
    private func getTaskLabel(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: fontSize)
        return label
    }
    
    private func getImageTaskView() -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.tasksCornerRadius
        image.widthAnchor.constraint(equalToConstant: Constants.tasksImageSize).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        return image
    }
    
    private func getDescriptionTaskLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Constants.textLabelSizeOfFont)
        return label
    }
    
    private func getDividerTaskView() -> UIView {
        let view = UIView()
        view.backgroundColor = .AppColors.accentColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.tasksDividerWidth).isActive = true
        return view
    }
    
    private func configureTaskView(index: Int, with: ProfileTaskModel) {
        guard index < taskViews.count else { return }
        chapterTaskIndicatorViews[index].backgroundColor = with.color ?? .AppColors.accentColor
//        imageTaskViews[index].image = with.image ?? .TaskIcons.defaultImage
        titleTaskLabels[index].text = with.title
//        descriptionTaskLabels[index].text = with.description ?? TaskString.description.rawValue.localized
        dividerTaskViews[index].backgroundColor = with.color ?? .AppColors.accentColor
        guard let date = with.deadline else {
//            deadlineTaskLabels[index].text = TaskString.deadline.rawValue.localized
            return
        }
        deadlineTaskLabels[index].text = date.formatted(date: .numeric, time: .shortened)
    }
    
    @objc
    private func showAllTasks() {
        
    }
    
    @objc
    private func openTask(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        guard let _ = taskViews.firstIndex(of: view) else { return }
    }
}

// MARK: - Friends View Configuration

extension ProfileViewController {
    private func configureFriends(isFriendsEmpty: Bool) {
        noFriendsLabel.isHidden = !isFriendsEmpty
        collectionView.isHidden = isFriendsEmpty
    }
    
    private func configureFriendsView() -> UIView {
        let view = getView()
        layoutFriendsController()
        configureStackView(arrangedSubviews: [titleLabelFriends, collectionView, noFriendsLabel],
                           spacing: Constants.spacingStackView,
                           toView: view)
        return view
    }
    
    private func layoutFriendsController() {
        collectionView.heightAnchor.constraint(equalToConstant: Constants.friendsConllectionHeight).isActive = true
    }
}

// MARK: - Helpers

extension ProfileViewController {
    private func configureStackView(arrangedSubviews: [UIView], spacing: CGFloat, toView: UIView, stackViewOffset: CGFloat = Constants.offset) {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = spacing
        toView.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: toView.topAnchor, constant: stackViewOffset).isActive = true
        stack.leftAnchor.constraint(equalTo: toView.leftAnchor, constant: stackViewOffset).isActive = true
        stack.rightAnchor.constraint(equalTo: toView.rightAnchor, constant: -stackViewOffset).isActive = true
        stack.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -stackViewOffset).isActive = true
    }
    
    private func getView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func getTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.titleLabelSizeOfFont)
        label.text = title
        label.textColor = .secondaryLabel
        return label
    }
    
    private func getSeparatorView() -> UIView {
        let view = getView()
        view.heightAnchor.constraint(equalToConstant: Constants.heightSeparator).isActive = true
        let innerView = getView()
        view.addSubview(innerView)
        innerView.backgroundColor = .AppColors.grey
        innerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        innerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.offsetSeparator).isActive = true
        innerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.offsetSeparator).isActive = true
        innerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return view
    }
}

// MARK: - Navigation Controller Setup

extension ProfileViewController {
    private func configureNavigationController(title: String, isMyScreen: Bool = false) {
        navigationItem.title = "@" + title
        navigationItem.rightBarButtonItem = isMyScreen ? settingButton : nil
        navigationController?.hidesBarsOnSwipe = true
    }
    
    @objc
    private func openSettings() {
        let profileEditViewController = ProfileEditViewController()
        profileEditViewController.configure(with: ProfileEditModel(login: information.login, image: profileImageView.image, summery: information.summary))
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return information.friends?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileFriendsCell.self), for: indexPath) as? ProfileFriendsCell else {
            return .init(frame: .zero)
        }
        guard let friends = information.friends else { return .init(frame: .zero) }
        cell.configureCell(with: friends[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {   }

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
