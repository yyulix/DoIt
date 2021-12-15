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

    private lazy var insideView: UIView = getView(rounded: true)
    
    private lazy var chapterIndicator: UIView = getView()
    
    private lazy var title: UILabel = getLabel(fontSize: UIConstants.titleFontSize)
    
    private lazy var taskDescription: UILabel = getLabel(numberOfLines: 0, textColor: .secondaryLabel)
    
    private lazy var deadline: UILabel = getLabel()
    
    private lazy var divider: UIView = getView()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = UIConstants.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var checkBox: UIButton = {
        let checkBox = UIButton()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    //MARK: - Public Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(taskInfo: Task) {
        chapterIndicator.backgroundColor = taskInfo.color
        taskInfo.isDone ? checkBox.setImage(.TaskIcons.done, for: .normal) : checkBox.setImage(.TaskIcons.notDone, for: .normal)
        
        var cellImage: UIImage? = nil
        if let data = try? Data(contentsOf: taskInfo.image!) {
            cellImage = UIImage(data: data)
        }
        
        image.image = cellImage ?? .TaskIcons.defaultImage
        title.text = taskInfo.title
        taskDescription.text = taskInfo.description ?? TaskString.description.rawValue.localized
        divider.backgroundColor = taskInfo.color
        
        guard let date = taskInfo.deadline else {
            deadline.text = TaskString.deadline.rawValue.localized
            return
        }
        deadline.text = date.formatted(date: .numeric, time: .shortened)
    }
    
    //MARK: - Private Methods
    private func configureUI() {
        contentView.layer.cornerRadius = UIConstants.cornerRadius
        selectionStyle = .none
        configureInsideView()
        configureIndicator()
        configureCheckbox()
        configureTitle()
        configureImage()
        configureDescription()
        configureDeadline()
        configureDivider()
    }
    
    private func configureInsideView() {
        addSubview(insideView)
        insideView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        insideView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        insideView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        insideView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
    }
    
    private func configureIndicator() {
        insideView.addSubview(chapterIndicator)
        chapterIndicator.topAnchor.constraint(equalTo: insideView.topAnchor).isActive = true
        chapterIndicator.leadingAnchor.constraint(equalTo: insideView.leadingAnchor).isActive = true
        chapterIndicator.bottomAnchor.constraint(equalTo: insideView.bottomAnchor).isActive = true
        chapterIndicator.widthAnchor.constraint(equalToConstant: UIConstants.indicatorWidth).isActive = true
    }
    
    private func configureCheckbox() {
        insideView.addSubview(checkBox)
        checkBox.topAnchor.constraint(equalTo: insideView.topAnchor, constant: UIConstants.paddingTop).isActive = true
        checkBox.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: UIConstants.buttonSize).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: UIConstants.buttonSize).isActive = true
    }
    
    private func configureImage() {
        insideView.addSubview(image)
        image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIConstants.space).isActive = true
        image.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        image.widthAnchor.constraint(equalToConstant: UIConstants.imageSize).isActive = true
        image.heightAnchor.constraint(equalToConstant: UIConstants.imageSize).isActive = true
    }
    
    private func configureTitle() {
        insideView.addSubview(title)
        title.topAnchor.constraint(equalTo: insideView.topAnchor, constant: UIConstants.paddingTop).isActive = true
        title.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        title.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: 2 * UIConstants.paddingRight - UIConstants.buttonSize).isActive = true
    }
    
    private func configureDescription() {
        insideView.addSubview(taskDescription)
        taskDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: UIConstants.space).isActive = true
        taskDescription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        taskDescription.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: 2 * UIConstants.paddingRight - UIConstants.buttonSize).isActive = true
        taskDescription.bottomAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
    }
    
    private func configureDeadline() {
        insideView.addSubview(deadline)
        deadline.topAnchor.constraint(equalTo: image.bottomAnchor, constant: UIConstants.space).isActive = true
        deadline.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        deadline.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: 2 * UIConstants.paddingRight - UIConstants.buttonSize).isActive = true
        deadline.bottomAnchor.constraint(equalTo: insideView.bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
    }
    
    private func configureDivider() {
        insideView.addSubview(divider)
        divider.leadingAnchor.constraint(equalTo: chapterIndicator.trailingAnchor, constant: UIConstants.paddingLeft).isActive = true
        divider.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: UIConstants.paddingRight).isActive = true
        divider.bottomAnchor.constraint(equalTo: insideView.bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: UIConstants.dividerWidth).isActive = true
    }
    
    private func getView(rounded: Bool = false) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        guard rounded else { return view }
        view.layer.masksToBounds = true
        view.layer.cornerRadius = UIConstants.cornerRadius
        return view
    }
    
    private func getLabel(numberOfLines: Int = 1, textColor: UIColor = .label, fontSize: CGFloat = UIConstants.descriptionFontSize) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.font = .systemFont(ofSize: fontSize)
        return label
    }
}
