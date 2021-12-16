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
        static let collectionViewCellSize: CGSize = .init(width: 120, height: 120)
        static let collectionViewInset: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        static let offset: CGFloat = 8
        static let spacingStackView: CGFloat = 8
        static let cornerRadius: CGFloat = 12
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
        static let stackViewSpacingAfterName: CGFloat = 0
        static let contentViewTopOffset: CGFloat = 50
        static let contentViewCornerRadius: CGFloat = 20
        static let titleLabelSizeOfFont: CGFloat = 12
        static let textLabelSizeOfFont: CGFloat = 14
        static let textInformationSizeOfFont: CGFloat = 12
        static let numberSizeOfFont: CGFloat = 20
        static let stackViewSpacingBetweenStackViews: CGFloat = 2
        static let tasksNumber: Int = 3
        static let tasksCornerRadius: CGFloat = 12
        static let tasksImageSize: CGFloat = 40
        static let tasksPaddingLeft: CGFloat = 13
        static let tasksTitleFontSize: CGFloat = 18
        static let tasksDividerWidth: CGFloat = 1
        static let tasksIndicatorWidth: CGFloat = 10
        static let friendsConllectionHeight: CGFloat = 120
        static let heightSeparator: CGFloat = 1
        static let offsetSeparator: CGFloat = 20
        static let showAllTasksWidth: CGFloat = 30
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
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()
    
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

        button.setTitle(FindUsersStrings.followButton.rawValue.localized, for: .normal)
        button.setTitle(FindUsersStrings.unfollowButton.rawValue.localized, for: .selected)
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
        button.setImage(.ProfileIcons.allTasksIcon, for: .normal)
        button.tintColor = .AppColors.accentColor
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(showAllTasks), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: Constants.showAllTasksWidth).isActive = true
        return button
    }()
    
    private var taskView: UIView {
        let view = getView()
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.tasksCornerRadius
        view.contentMode = .scaleAspectFit
        return view
    }
    
    private var chapterIndicatorTaskView: UIView {
        let view = getView()
        view.widthAnchor.constraint(equalToConstant: Constants.tasksIndicatorWidth).isActive = true
        return view
    }
    
    private var titleTaskLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.tasksTitleFontSize)
        return label
    }
    
    private var imageTaskView: UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.tasksCornerRadius
        image.widthAnchor.constraint(equalToConstant: Constants.tasksImageSize).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        return image
    }
    
    private var descriptionTaskLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Constants.textLabelSizeOfFont)
        return label
    }
    
    private var deadlineTaskLabel: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.textLabelSizeOfFont)
        return label
    }
    
    private var dividerTaskView: UIView {
        let view = UIView()
        view.backgroundColor = .AppColors.accentColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.tasksDividerWidth).isActive = true
        return view
    }
    
    private struct TaskViewData {
        let taskView: UIView
        let chapterTaskIndicatorView: UIView
        let titleTaskLabel: UILabel
        let imageTaskLabel: UIImageView
        let desciptionTaskLabel: UILabel
        let deadlineTaskLabel: UILabel
        let dividerTaskView: UIView
    }
    
    // MARK: - Following View
    
    private lazy var titleLabelFollowing: UILabel = getTitleLabel(title: ProfileStrings.titleFollowings.rawValue.localized)
    
    private lazy var noFollowingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.textLabelSizeOfFont)
        label.text = ProfileStrings.noFollowings.rawValue.localized
        label.isHidden = true
        return label
    }()
    
    private lazy var followingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Constants.collectionViewCellSize
        
        layout.sectionInset = Constants.collectionViewInset
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ProfileFollowingUserCell.self, forCellWithReuseIdentifier: String(describing: ProfileFollowingUserCell.self))
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    private var headerHeightConstraint: NSLayoutConstraint = .init()
    
    // MARK: - Task View
    
    private lazy var taskViews: [TaskViewData] = []
    
    // MARK: - Configuration
    
    var viewModel: ProfileViewModel = ProfileViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        viewModel.userModel.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.configureCells()
            }
        }
        
        viewModel.userTasksModel.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.configureTasks()
                self?.configureStatistics()
            }
        }
        
        viewModel.userFollowingModel.bind { _ in
            DispatchQueue.main.async { [weak self] in
                self?.configureFollowing()
            }
        }
        
        viewModel.getUserTasks()
        viewModel.getUserFollowings()
    }
    
    // MARK: - Helpers
    
    private func configureCells() {
        guard let userModel = viewModel.userModel.value else { return }
        configureNavigationController(title: viewModel.userModel.value?.username ?? "", isMyScreen: viewModel.userModel.value?.isCurrentUser ?? false)
        configureHeader(imageURL: userModel.image, name: userModel.name, login: userModel.username, isFollowed: userModel.isFollowed ?? false, isMyScreen: userModel.isCurrentUser)
        configureInformation(summary: userModel.summary)
        configureStatistics()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        layoutScrollView()
        layoutCellsStackView()
        configureNavigationController(title: viewModel.userModel.value?.username ?? "", isMyScreen: viewModel.userModel.value?.isCurrentUser ?? false)
        configureCells()
    }
    
    private func configureNavigationController(title: String, isMyScreen: Bool = false) {
        navigationItem.title = "@" + title
        navigationItem.rightBarButtonItem = isMyScreen ? settingButton : nil
        navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - Layout

extension ProfileViewController {
    // MARK: - Main
    
    private func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func layoutCellsStackView() {
        let allViews = [configureHeaderView(), configureInformationView(), getSeparatorView(), configureStatisticsView(), getSeparatorView(), configureTasksView(), getSeparatorView(), configureFollowingView(), getSeparatorView()]
        
        configureStackView(arrangedSubviews: allViews, spacing: Constants.spacingStackView, toView: scrollView, isEqualWidthToView: true)
    }
    
    // MARK: - Header View
    
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
    
    private func configureHeaderStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, loginLabel, followButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Constants.stackViewSpacingHeader
        stack.alignment = .center
        stack.setCustomSpacing(Constants.stackViewSpacingAfterName, after: nameLabel)
        return stack
    }
    
    // MARK: - Information View
    
    private func configureInformationView() -> UIView {
        let view = getView()
        configureStackView(arrangedSubviews: [titleLabelInformation, summaryLabel], spacing: Constants.spacingStackView, toView: view)
        return view
    }
    
    // MARK: - Statistics View
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
    
    // MARK: - Tasks View
    
    private func configureTasksView() -> UIView {
        let view = getView()
        
        for _ in 0..<Constants.tasksNumber {
            createTaskView()
        }
        
        var arrangedSubviews: [UIView] = [getTasksSubStackView(arrangedSubviews: [titleLabelTasks, showAllTasksButton])]
        arrangedSubviews.append(contentsOf: taskViews.map({ $0.taskView }))
        arrangedSubviews.append(noTasksLabel)
        
        taskViews.forEach {
            $0.taskView.isHidden = true
            $0.taskView.isUserInteractionEnabled = true
            $0.taskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTask(_:))))
        }
        
        configureStackView(arrangedSubviews: arrangedSubviews, spacing: Constants.spacingStackView, toView: view)
        return view
    }
    
    private func createTaskView() {
        let view = taskView
        let taskViewData = TaskViewData(taskView: view,
                                        chapterTaskIndicatorView: layoutTaskChapterIndicatorView(rootView: view),
                                        titleTaskLabel: titleTaskLabel,
                                        imageTaskLabel: imageTaskView,
                                        desciptionTaskLabel: descriptionTaskLabel,
                                        deadlineTaskLabel: deadlineTaskLabel,
                                        dividerTaskView: dividerTaskView)
        
        taskViews.append(taskViewData)
        let subArrangedSubviews = [taskViewData.imageTaskLabel, taskViewData.desciptionTaskLabel]
        let arrangedSubviews = [taskViewData.titleTaskLabel, getTasksSubStackView(arrangedSubviews: subArrangedSubviews), taskViewData.deadlineTaskLabel, taskViewData.dividerTaskView]
        layoutTasksMainStackView(rootView: view, chapterIndicatorView: taskViewData.chapterTaskIndicatorView, arrangedSubviews: arrangedSubviews)
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
    
    private func layoutTaskChapterIndicatorView(rootView: UIView) -> UIView {
        let chapterIndicatorView = chapterIndicatorTaskView
        rootView.addSubview(chapterIndicatorView)
        chapterIndicatorView.topAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
        chapterIndicatorView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor).isActive = true
        chapterIndicatorView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor).isActive = true
        return chapterIndicatorView
    }
    
    // MARK: - Following View
    
    private func configureFollowingView() -> UIView {
        let view = getView()
        followingCollectionView.heightAnchor.constraint(equalToConstant: Constants.friendsConllectionHeight).isActive = true
        configureStackView(arrangedSubviews: [titleLabelFollowing, followingCollectionView, noFollowingLabel],
                           spacing: Constants.spacingStackView,
                           toView: view)
        return view
    }
    
    // MARK: - Helpers
    
    private func configureStackView(arrangedSubviews: [UIView], spacing: CGFloat, toView: UIView, stackViewOffset: CGFloat = Constants.offset, isEqualWidthToView: Bool = false) {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = spacing
        toView.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: toView.topAnchor, constant: stackViewOffset).isActive = true
        stack.leftAnchor.constraint(equalTo: toView.leftAnchor, constant: stackViewOffset).isActive = true
        stack.rightAnchor.constraint(equalTo: toView.rightAnchor, constant: -stackViewOffset).isActive = true
        stack.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -stackViewOffset).isActive = true
        if isEqualWidthToView {
            stack.widthAnchor.constraint(equalTo: toView.widthAnchor, constant: -2 * stackViewOffset).isActive = true
        }
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
        innerView.backgroundColor = .AppColors.greyColor
        innerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        innerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.offsetSeparator).isActive = true
        innerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.offsetSeparator).isActive = true
        innerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return view
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
}

// MARK: - Configuration

extension ProfileViewController {
    // MARK: - Header
    
    private func configureHeader(imageURL: URL?, name: String?, login: String, isFollowed: Bool, isMyScreen: Bool) {
        configureHeaderHeight(withName: name != nil, isMyScreen: isMyScreen)
        configureProfileImage(imageURL: imageURL, name: name, login: login)
        
        nameLabel.text = name
        loginLabel.text = "@" + login
        
        configureFollowButton(isFollowed: isFollowed)
        followButton.isHidden = isMyScreen
    }
    
    private func configureFollowButton(isFollowed: Bool) {
        followButton.isSelected = isFollowed
        followButton.backgroundColor = isFollowed ? .AppColors.greyColor : .AppColors.accentColor
    }
    
    private func configureHeaderHeight(withName: Bool, isMyScreen: Bool) {
        if withName {
            headerHeightConstraint.constant = isMyScreen ? Constants.myHeaderHeightWithName : Constants.headerHeightWithName
        } else {
            headerHeightConstraint.constant = isMyScreen ? Constants.myHeaderHeight : Constants.headerHeight
        }
    }
    
    private func configureProfileImage(imageURL: URL?, name: String?, login: String) {
        guard let imageURL = imageURL else {
            profileImageView.layoutIfNeeded()
            profileImageView.setImageForName(name ?? login, circular: false, textAttributes: nil)
            return
        }
        viewModel.downloadImage(imageURL) { image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.profileImageView.image = image
            }
        }
    }
    
    // MARK: - Information View
    
    private func configureInformation(summary: String?) {
        summaryLabel.text = summary ?? ProfileStrings.summaryPlaceholder.rawValue.localized
    }
    
    // MARK: - Statistics View
    
    private func configureStatistics() {
        let tasks = viewModel.userTasksModel.value?.tasks ?? []
        DispatchQueue.global().async {
            var done = 0
            var outdated = 0
            var inProgress = 0
            let total = tasks.count
            let currentDate = Date()
            tasks.forEach { task in
                guard !task.isDone else { done += 1; return }
                guard let deadline = task.deadline else { inProgress += 1; return }
                guard deadline > currentDate else { outdated += 1; return }
                inProgress += 1
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.inProgressNumberLabel.text = "\(inProgress)"
                self?.outdatedNumberLabel.text = "\(outdated)"
                self?.doneNumberLabel.text = "\(done)"
                self?.totalNumberLabel.text = "\(total)"
            }
        }
    }
    
    // MARK: - Tasks View
    
    private func configureTasks() {
        let with = viewModel.userTasksModel.value?.tasks ?? []
        let taskToConfigure = min(with.count, taskViews.count)
        for i in 0..<taskToConfigure {
            configureTaskView(index: i, with: with[i])
        }
        
        showTasks(count: taskToConfigure)
        noTasksLabel.isHidden = taskToConfigure != 0
        showAllTasksButton.isHidden = taskToConfigure == 0
    }
    
    private func showTasks(count: Int) {
        for i in 0..<count {
            taskViews[i].taskView.isHidden = false
        }
        hideTasks(fromTaskIndex: count)
    }
    
    private func hideTasks(fromTaskIndex: Int) {
        for i in fromTaskIndex..<taskViews.count {
            taskViews[i].taskView.isHidden = true
        }
    }
    
    private func configureTaskView(index: Int, with: Task) {
        guard index < taskViews.count else { return }
        taskViews[index].chapterTaskIndicatorView.backgroundColor = with.color
        taskViews[index].imageTaskLabel.image = .TaskIcons.defaultImage
        taskViews[index].titleTaskLabel.text = with.title
        taskViews[index].desciptionTaskLabel.text = with.description ?? TaskString.description.rawValue.localized
        taskViews[index].dividerTaskView.backgroundColor = with.color
        
        if let taskURL = with.image {
            viewModel.downloadImage(taskURL) { image in
                guard let image = image else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.taskViews[index].imageTaskLabel.image = image
                }
            }
        }
        guard let date = with.deadline else {
            taskViews[index].deadlineTaskLabel.text = TaskString.deadline.rawValue.localized
            return
        }
        taskViews[index].deadlineTaskLabel.text = date.formatted(date: .numeric, time: .shortened)
    }
    
    // MARK: - Following View
    
    private func configureFollowing() {
        let isFollowingEmpty = (viewModel.userFollowingModel.value?.followings ?? []).count == 0 ? true : false
        noFollowingLabel.isHidden = !isFollowingEmpty
        followingCollectionView.isHidden = isFollowingEmpty
    }
}

// MARK: - Collection View Description

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profileViewController = ProfileViewController()
        profileViewController.viewModel.userModel.value = viewModel.userFollowingModel.value?.followings[indexPath.row]
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.userFollowingModel.value?.followings.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileFollowingUserCell.self), for: indexPath) as? ProfileFollowingUserCell else {
            return .init(frame: .zero)
        }
        guard let userFollowingModel = viewModel.userFollowingModel.value else { return .init() }
        cell.configureCell(with: userFollowingModel.followings[indexPath.row])
        viewModel.downloadImage(userFollowingModel.followings[indexPath.row].image) { image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                cell.configureImage(image)
            }
        }
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {   }

// MARK: - Actions

extension ProfileViewController {
    @objc
    private func showAllTasks() {
        guard let userModel = viewModel.userModel.value else { return }
        guard !userModel.isCurrentUser else {
            NotificationCenter.default.post(name: .openTasksFromProfile, object: nil)
            navigationController?.popToRootViewController(animated: true)
            return
        }
        let viewController = FeedController()
        viewController.userModel = userModel
        viewController.following = [userModel]
        viewController.followingUsersTasks = viewModel.userTasksModel.value?.tasks ?? []
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func openTask(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        guard let i = taskViews.firstIndex(where: { $0.taskView == view } ) else { return }
        
        let taskViewController = TaskViewController()
        taskViewController.taskModel = viewModel.userTasksModel.value?.tasks[i]
        taskViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(taskViewController, animated: true)
    }
    
    @objc
    private func didTapFollowButton() {
        guard let userModel = viewModel.userModel.value else { return }
        guard let isFollowed = userModel.isFollowed else { return }
        if isFollowed {
            viewModel.unfollowUser(userModel) { [weak self] done in
                guard done else {
                    
                    return
                }
                DispatchQueue.main.async {
                    self?.switchFollowButtonAnimated()
                }
            }
        } else {
            viewModel.followUser(userModel) { [weak self] done in
                guard done else {
                    
                    return
                }
                DispatchQueue.main.async {
                    self?.switchFollowButtonAnimated()
                }
            }
        }
    }
    
    @objc
    private func openSettings() {
        let profileEditViewController = ProfileEditViewController()
        profileEditViewController.viewModel.userModel = viewModel.userModel
        profileEditViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileEditViewController, animated: true)
    }
}
