//
//  CustomUIElementsProfile.swift
//  DoIt
//
//  Created by Шестаков Никита on 03.11.2021.
//

import Foundation
import UIKit

final class InputBox: UIView {
    // MARK: - Properties
    
    struct Constants {
        static let fontSize: CGFloat = 17
        static let padding: CGFloat = 8.0
        static let paddingRight: CGFloat = -28.0
        static let adjustWidthToTextView: CGFloat = 8
        static let underScopeViewHeight: CGFloat = 1
    }
    
    var textView: UITextView = UITextView()
    var placeholder: String?
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            guard text != "" else { return }
            removePlaceholder()
            textView.text = text
        }
    }
    
    
    private var isOversized = false {
        didSet {
            guard textView.contentSize.height != previousHeight else { return }
            guard textView.contentSize.height <= maxHeight else { return }
            textView.isScrollEnabled = isOversized
            textView.sizeToFit()
            textView.layoutIfNeeded()
        }
    }
    
    private var maxHeight: CGFloat = 0
    private var previousHeight: CGFloat = 0
    private var underScopeView: UIView = UIView()
    
    // MARK: - Initializers
    
    init(maxHeight: CGFloat, placeholder: String? = nil) {
        self.maxHeight = maxHeight
        self.placeholder = placeholder
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func removePlaceholder() {
        guard let placeholder = placeholder else { return }
        guard textView.text.isEmpty || textView.text == placeholder else { return }
        textView.text = ""
        textView.textColor = .label
    }
    
    func setPlaceholder() {
        guard textView.text.isEmpty else { return }
        guard let placeholder = placeholder else { return }
        
        textView.text = placeholder
        textView.textColor = .secondaryLabel.withAlphaComponent(0.3)
    }
    
    func updateLayout() {
        isOversized = textView.contentSize.height >= maxHeight
        previousHeight = textView.contentSize.height
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        configureUnderScopeView()
        configureTextView()
        setPlaceholder()
    }
    
    private func configureTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: underScopeView.widthAnchor, constant: Constants.adjustWidthToTextView).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        textView.centerXAnchor.constraint(equalTo: underScopeView.centerXAnchor).isActive = true
        
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: Constants.fontSize)
        textView.layer.zPosition = 1
    }
    
    private func configureUnderScopeView() {
        underScopeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underScopeView)
        underScopeView.heightAnchor.constraint(equalToConstant: Constants.underScopeViewHeight).isActive = true
        underScopeView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding).isActive = true
        underScopeView.rightAnchor.constraint(equalTo: rightAnchor, constant: Constants.paddingRight).isActive = true
        underScopeView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        underScopeView.backgroundColor = .AppColors.accentColor
        underScopeView.layer.zPosition = 2
    }
}

final class ProfileTaskView: UIView {
    // MARK: - Properties
    
    private struct Constants {
        static let tasksCornerRadius = 12.0
        static let tasksImageSize = 40.0
        static let tasksPaddingLeft = 13.0
        static let tasksTitleFontSize = 20.0
        static let tasksDescriptionFontSize = 16.0
        static let tasksDividerWidth = 1.0
        static let tasksIndicatorWidth = 10.0
    }
    
    private let chapterIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: Constants.tasksIndicatorWidth).isActive = true
        return view
    }()
    
    private let titleTasksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.tasksTitleFontSize)
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.tasksCornerRadius
        image.widthAnchor.constraint(equalToConstant: Constants.tasksImageSize).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        return image
    }()
    
    private let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Constants.tasksDescriptionFontSize)
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.tasksDescriptionFontSize)
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .AppColors.accentColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.tasksDividerWidth).isActive = true
        return view
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureCell(with: ProfileTaskModel) {
        chapterIndicatorView.backgroundColor = with.color ?? .AppColors.accentColor
//        imageView.image = with.image ?? .TaskIcons.defaultImage
        titleTasksLabel.text = with.title
//        taskDescriptionLabel.text = with.description ?? TaskString.description.rawValue.localized
        dividerView.backgroundColor = with.color ?? .AppColors.accentColor
        guard let date = with.deadline else {
//            deadline.text = TaskString.deadline.rawValue.localized
            return
        }
        deadlineLabel.text = DateFormatter().string(from: date)
    }
    
    //MARK: - Private Methods
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        layer.masksToBounds = true
        layer.cornerRadius = Constants.tasksCornerRadius
        contentMode = .scaleAspectFit
        
        layoutTaskIndicator()
        layoutTasksMainStackView()
    }
    
    private func layoutTasksMainStackView() {
        let stack = UIStackView(arrangedSubviews: [titleTasksLabel, getTasksSubStackView(), deadlineLabel, dividerView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.axis = .vertical
        addSubview(stack)
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: chapterIndicatorView.rightAnchor, constant: Constants.tasksPaddingLeft).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func getTasksSubStackView() -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [imageView, taskDescriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }
    
    private func layoutTaskIndicator() {
        addSubview(chapterIndicatorView)
        chapterIndicatorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        chapterIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        chapterIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
