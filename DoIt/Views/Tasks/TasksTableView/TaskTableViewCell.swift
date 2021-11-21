//
//  TaskTableViewCell.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Private Property
    private struct UIConstants {
        static let cornerRadius = 12.0
        static let imageSize = 75.0
        static let buttonSize = 30.0
        static let indicatorWidth = 10.0
        static let paddingTop = 10.0
        static let paddingBottom = -13.0
        static let paddingLeft = 13.0
        static let paddingRight = -13.0
        static let titleFontSize = 22.0
        static let descriptionFontSize = 16.0
        static let space = 10.0
        static let dividerWidth = 1.0
    }

    private let insideView: UIView = {
        let insideView = UIView()
        insideView.translatesAutoresizingMaskIntoConstraints = false
        insideView.layer.masksToBounds = true
        insideView.contentMode = .scaleAspectFit
        return insideView
    }()
    
    private let chapterIndicator: UIView = {
        let indicator = UIView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let checkBox: UIButton = {
        let checkBox = UIButton()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = title.font.withSize(UIConstants.titleFontSize)
        title.textColor = UIColor.AppColors.mainTextColor
        return title
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let taskDescription: UILabel = {
        let taskDescription = UILabel()
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.textColor = UIColor.AppColors.minorTextColor
        taskDescription.textAlignment = NSTextAlignment.left
        taskDescription.numberOfLines = 0
        return taskDescription
    }()
    
    private let deadline: UILabel = {
        let deadline = UILabel()
        deadline.translatesAutoresizingMaskIntoConstraints = false
        deadline.textColor = UIColor.AppColors.taskDeadlineColor
        return deadline
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor.AppColors.accentColor
        //поменять цвет на UIColor.AppColors.accentColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    //MARK: - Public Methods
    func configureCell(taskInfo: Task) {
        contentView.layer.cornerRadius = UIConstants.cornerRadius
        self.selectionStyle = .none
        
        configureInsideView()
        configureIndicator(color: taskInfo.color)
        configureCheckbox(isDone: taskInfo.isDone)
        configureTitle(titleText: taskInfo.title)
        configureImage(cellImage: taskInfo.image)
        configureDescription(description: taskInfo.description)
        configureDeadline(date: taskInfo.deadline)
        configureDivider(color: taskInfo.color)
    }
    
    //MARK: - Private Methods
    private func configureInsideView() {
        addSubview(insideView)
        insideView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        insideView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        insideView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        insideView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
        insideView.layer.cornerRadius = UIConstants.cornerRadius
    }
    
    private func configureIndicator(color: UIColor?) {
        insideView.addSubview(chapterIndicator)
        chapterIndicator.topAnchor.constraint(equalTo: insideView.topAnchor).isActive = true
        chapterIndicator.leadingAnchor.constraint(equalTo: insideView.leadingAnchor).isActive = true
        chapterIndicator.bottomAnchor.constraint(equalTo: insideView.bottomAnchor).isActive = true
        chapterIndicator.widthAnchor.constraint(equalToConstant: UIConstants.indicatorWidth).isActive = true
        chapterIndicator.backgroundColor = color ?? UIColor.AppColors.accentColor
    }
    
    private func configureCheckbox(isDone: Bool) {
        insideView.addSubview(checkBox)
        isDone ? checkBox.setImage(UIImage.TaskIcons.done, for: .normal) : checkBox.setImage(UIImage.TaskIcons.notDone, for: .normal)
        checkBox.topAnchor.constraint(equalTo: insideView.topAnchor, constant: UIConstants.paddingTop).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: UIConstants.buttonSize).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: UIConstants.buttonSize).isActive = true
    }
    
    private func configureImage(cellImage: UIImage?) {
        insideView.addSubview(image)
        image.image = cellImage ?? UIImage.TaskIcons.defaultImage
        image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIConstants.space).isActive = true
        image.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        image.widthAnchor.constraint(equalToConstant: UIConstants.imageSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: UIConstants.imageSize).isActive = true
    }
    
    private func configureTitle(titleText: String) {
        insideView.addSubview(title)
        title.text = titleText
        title.topAnchor.constraint(equalTo: insideView.topAnchor, constant: UIConstants.paddingTop).isActive = true
        title.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        title.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight - UIConstants.buttonSize + UIConstants.paddingRight).isActive = true
    }
    
    private func configureDescription(description: String?) {
        insideView.addSubview(taskDescription)
        taskDescription.font = taskDescription.font.withSize(UIConstants.descriptionFontSize)
        taskDescription.text = description ?? TaskString.description.rawValue.localized
        taskDescription.font = title.font.withSize(UIConstants.descriptionFontSize)
        taskDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIConstants.space).isActive = true
        taskDescription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        taskDescription.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight - UIConstants.buttonSize + UIConstants.paddingRight).isActive = true
        taskDescription.bottomAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
    }
    
    private func configureDeadline(date: Date?) {
        insideView.addSubview(deadline)
        if let _ = date {
            deadline.text = DateFormatter().string(from: date!)
        } else {
            deadline.text = TaskString.deadline.rawValue.localized
        }
        deadline.font = deadline.font.withSize(UIConstants.descriptionFontSize)
        deadline.topAnchor.constraint(equalTo: image.bottomAnchor, constant: UIConstants.space).isActive = true
        deadline.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        deadline.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight - UIConstants.buttonSize + UIConstants.paddingRight).isActive = true
        deadline.bottomAnchor.constraint(equalTo: insideView.bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
    }
    
    private func configureDivider(color: UIColor?) {
        insideView.addSubview(divider)
        divider.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        divider.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight).isActive = true
        divider.bottomAnchor.constraint(equalTo: insideView.bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: UIConstants.dividerWidth).isActive = true
        divider.backgroundColor = color ?? UIColor.AppColors.accentColor
    }
}
