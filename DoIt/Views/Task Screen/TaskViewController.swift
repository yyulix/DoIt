//
//  TaskViewController.swift
//  DoIt
//
//  Created by Данил Швец on 01.12.2021.
//

import UIKit

class TaskViewController: UIViewController {
    
    private struct UIConstants {
        static let boldFontSize = 28.0
        static let normalFontSize = 24.0
        static let navigationBarFontSize = 26.0
        static let stackPadding = 20.0
        static let verticalStackSpacing = 10.0
        static let horizontalStackSpacing = 20.0
        static let referencePadding = 116.0
    }
    
    private var timer: Timer?
    private let currentDate = Date()
    private let futureDate: Date = {
        var future = DateComponents(
            year: 2021,
            month: 12,
            day: 5,
            hour: 10,
            minute: 20,
            second: 30
        )
        return Calendar.current.date(from: future)!
    }()
    private var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
    }
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    private var timerTitle: UITextView = {
       let timerTitle = UITextView()
        timerTitle.translatesAutoresizingMaskIntoConstraints = false
        timerTitle.font = UIFont.boldSystemFont(ofSize: UIConstants.boldFontSize)
        timerTitle.textColor = UIColor.black
        timerTitle.isEditable = false
        timerTitle.isScrollEnabled = false
        timerTitle.backgroundColor = .white
        return timerTitle
    }()
    private var timerLabel: UITextView = {
       let timerLabel = UITextView()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: UIConstants.normalFontSize)
        timerLabel.textColor = .black
        timerLabel.textAlignment = .center
        timerLabel.isEditable = false
        timerLabel.isScrollEnabled = false
        timerLabel.backgroundColor = .white
        return timerLabel
    }()
    private var taskDescriptionTitle: UITextView = {
       let taskDescriptionTitle = UITextView()
        taskDescriptionTitle.translatesAutoresizingMaskIntoConstraints = false
        taskDescriptionTitle.font = UIFont.boldSystemFont(ofSize: UIConstants.boldFontSize)
        taskDescriptionTitle.textColor = UIColor.black
        taskDescriptionTitle.isEditable = false
        taskDescriptionTitle.isScrollEnabled = false
        taskDescriptionTitle.backgroundColor = .white
        return taskDescriptionTitle
    }()
    private var taskDescription: UITextView = {
       let taskDescription = UITextView()
        taskDescription.translatesAutoresizingMaskIntoConstraints = false
        taskDescription.sizeToFit()
        taskDescription.font = UIFont.systemFont(ofSize: UIConstants.normalFontSize)
        taskDescription.textColor = .black
        taskDescription.textAlignment = .center
        taskDescription.isEditable = false
        taskDescription.backgroundColor = .white
        return taskDescription
    }()
    private var taskChapterTitle: UITextView = {
       let taskChapterTitle = UITextView()
        taskChapterTitle.translatesAutoresizingMaskIntoConstraints = false
        taskChapterTitle.font = UIFont.boldSystemFont(ofSize: UIConstants.boldFontSize)
        taskChapterTitle.textColor = UIColor.black
        taskChapterTitle.isEditable = false
        taskChapterTitle.isScrollEnabled = false
        taskChapterTitle.backgroundColor = .white
        return taskChapterTitle
    }()
    private lazy var taskChapter: UITextView = {
        let taskChapter = UITextView()
        taskChapter.translatesAutoresizingMaskIntoConstraints = false
        taskChapter.font = UIFont.systemFont(ofSize: UIConstants.normalFontSize)
        taskChapter.textColor = .black
        taskChapter.isEditable = false
        taskChapter.isScrollEnabled = false
        taskChapter.backgroundColor = .white
        return taskChapter
    }()
    private var taskImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        return image
    }()
    
    private lazy var deleteButton = TaskButton(imageName: UIImage(systemName: "trash.circle"), target: self, action: #selector(deleteButtonPressed), width: UIScreen.main.bounds.width / 4, color: .lightGray)
    private lazy var doneButton = TaskButton(imageName: UIImage(systemName: "checkmark"), target: self, action: #selector(doneButtonPressed), width: UIScreen.main.bounds.width / 4, color: UIColor.AppColors.doneColor)
    private lazy var editButton = TaskButton(imageName: UIImage(systemName: "square.and.pencil"), target: self, action: #selector(editButtonPressed), width: UIScreen.main.bounds.width / 4, color: UIColor.AppColors.accentColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureView()
        runCountdown()
    }
    
    func runCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func configureNavigationBar() {
        let navigationBarView = UIView()
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Helvetica Neue Bold", size: UIConstants.navigationBarFontSize)
        label.sizeToFit()
        label.center = navigationBarView.center
        label.textAlignment = NSTextAlignment.center

        let image = UIImageView()
        image.image = UIImage(systemName: "xmark.square")
        image.tintColor = UIColor(red: 0.78, green: 0.00, blue: 0.22, alpha: 1.00)
        let imageAspect = image.image!.size.width/image.image!.size.height
        image.frame = CGRect(x: label.frame.origin.x + label.frame.width + 10, y: label.frame.origin.y, width: label.frame.size.height * imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        navigationBarView.addSubview(image)
        navigationBarView.addSubview(label)
        self.navigationItem.titleView = navigationBarView
        navigationBarView.sizeToFit()
    }
    
    func configureDoneNavigationBar() {
        let navigationBarView = UIView()
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Helvetica Neue Bold", size: UIConstants.navigationBarFontSize)
        label.sizeToFit()
        label.center = navigationBarView.center
        label.textAlignment = NSTextAlignment.center

        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark.circle")
        image.tintColor = UIColor(red: 0.18, green: 0.72, blue: 0.45, alpha: 1.00)
        let imageAspect = image.image!.size.width/image.image!.size.height
        image.frame = CGRect(x: label.frame.origin.x + label.frame.width + 10, y: label.frame.origin.y, width: label.frame.size.height * imageAspect, height: label.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        navigationBarView.addSubview(image)
        navigationBarView.addSubview(label)
        self.navigationItem.titleView = navigationBarView
        navigationBarView.sizeToFit()
    }
    
    func configureView() {
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        let horizontalStack = UIStackView(arrangedSubviews: [deleteButton, doneButton, editButton])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = UIConstants.horizontalStackSpacing
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        timerTitle.text = TaskScreen.countdown.rawValue.localized
        timerTitle.textAlignment = .left
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        taskChapterTitle.text = TaskScreen.chapter.rawValue.localized
        taskChapterTitle.textAlignment = .left
        
        taskChapter.text = ""
        taskChapter.textAlignment = .center
        
        taskDescriptionTitle.text = TaskScreen.description.rawValue.localized
        taskDescriptionTitle.textAlignment = .left
        
        taskDescription.text = ""
        taskDescription.isScrollEnabled = false
        taskDescription.sizeToFit()
        
        taskImage.image = UIImage(named: "")
        let imageViewWidthConstraint = NSLayoutConstraint(item: taskImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.bounds.width / 2)
        let imageViewHeightConstraint = NSLayoutConstraint(item: taskImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.bounds.width / 2)
        taskImage.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        
        let verticalStack = UIStackView(arrangedSubviews: [timerTitle, timerLabel, taskChapterTitle, taskChapter, taskDescriptionTitle, taskDescription, taskImage, horizontalStack])
        scrollView.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -UIConstants.stackPadding).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: UIConstants.stackPadding).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -UIConstants.stackPadding).isActive = true
        verticalStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2 * UIConstants.stackPadding).isActive = true
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
        verticalStack.spacing = UIConstants.verticalStackSpacing
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        let verticalStackHeight = verticalStack.frame.height
        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom
        let topPadding = window?.safeAreaInsets.top
        let referenceHeight = view.bounds.height - bottomPadding! - topPadding! - UIConstants.referencePadding
        if referenceHeight > verticalStackHeight {
            verticalStack.removeArrangedSubview(horizontalStack)
            view.addSubview(horizontalStack)
            horizontalStack.translatesAutoresizingMaskIntoConstraints = false
            horizontalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            horizontalStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIConstants.stackPadding).isActive = true
            horizontalStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -UIConstants.stackPadding).isActive = true
        }
    }
    
    @objc func deleteButtonPressed(){
        
    }
    
    @objc func doneButtonPressed(){
        timer?.invalidate()
        configureDoneNavigationBar()
        timerLabel.text = "00:00:00:00"
        timerLabel.textColor = UIColor.AppColors.doneColor
    }

    @objc func editButtonPressed(){
        let taskEditController = TaskEditViewController()
        let navEditController = UINavigationController(rootViewController: taskEditController)
        present(navEditController, animated: true, completion: nil)
    }
    
    @objc func updateTime() {
        let countdown = self.countdown
        let days = countdown.day!
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!
        if futureDate < currentDate {
            timerLabel.text = "00:00:00:00"
            timerLabel.textColor = .red
        } else {
            timerLabel.text = String(format: "%02i:%02i:%02i:%02i", days, hours, minutes, seconds)
        }
    }
}
