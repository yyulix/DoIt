//
//  TaskEditViewController.swift
//  DoIt
//
//  Created by Данил Швец on 01.12.2021.
//

import UIKit

class TaskEditViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    private struct UIConstants {
        static let boldFontSize = 28.0
        static let normalFontSize = 24.0
        static let navigationBarFontSize = 26.0
        static let stackPadding = 20.0
        static let verticalStackSpacing = 10.0
        static let horizontalStackSpacing = 20.0
        static let referencePadding = 116.0
    }
    
    private let screenSize: CGFloat = 667.0
    private let datePicker = UIDatePicker()
    private let chapterPicker = UIPickerView()
    private let dateFormatter = DateFormatter()
    private lazy var imagePicker = UIImagePickerController()
    private let chapters = [TaskCategory(index: 0), TaskCategory(index: 1), TaskCategory(index: 2), TaskCategory(index: 3), TaskCategory(index: 4), TaskCategory(index: 5), TaskCategory(index: 6), TaskCategory(index: 7), TaskCategory(index: 8), TaskCategory(index: 9), TaskCategory(index: 10), TaskCategory(index: 11), TaskCategory(index: 12), TaskCategory(index: 13), TaskCategory(index: 14)]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    private var taskLabel: UITextField = {
        let label = UITextField()
        label.placeholder = "Задача"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica Neue Bold", size: UIConstants.navigationBarFontSize)
        label.textAlignment = .center
        return label
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
    private var timerLabel: UITextField = {
       let timerLabel = UITextField()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.font = UIFont.systemFont(ofSize: UIConstants.normalFontSize)
        timerLabel.placeholder = TaskScreen.deadline.rawValue.localized
        timerLabel.textColor = .gray
        timerLabel.textAlignment = .center
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
    private lazy var taskChapter: UITextField = {
        let taskChapter = UITextField()
        taskChapter.translatesAutoresizingMaskIntoConstraints = false
        taskChapter.placeholder = TaskScreen.chapter.rawValue.localized
        taskChapter.textAlignment = .center
        taskChapter.font = UIFont.systemFont(ofSize: UIConstants.normalFontSize)
        taskChapter.textColor = .gray
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
    
    private lazy var returnButton = CustomRoundedTaskButton(title: TaskScreen.returnButton.rawValue.localized, target: self, action: #selector(returnButtonPressed), width: UIScreen.main.bounds.width / 3, color: .lightGray)
    private lazy var saveButton = CustomRoundedTaskButton(title: TaskScreen.saveButton.rawValue.localized, target: self, action: #selector(saveButtonPressed), width: UIScreen.main.bounds.width / 3, color: UIColor.AppColors.accentColor)
    private lazy var setImageButton = CustomRoundedTaskButton(title: TaskScreen.changePhotoButton.rawValue.localized, target: self, action: #selector(imageSetButtonPressed), width: UIScreen.main.bounds.width / 2, color: UIColor(red: 0.53, green: 0.46, blue: 0.66, alpha: 1.00))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDescription.delegate = self
        navigationController?.navigationBar.isHidden = true
        configureView()
        createDatePicker()
        createChapterPicker()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return chapters[row].chapter
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        taskChapter.text = "\(chapters[row].chapter!)"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return chapters.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func createChapterPicker() {
        chapterPicker.dataSource = self
        chapterPicker.delegate = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(chapterDoneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        let chapterPickerPreferredSize = chapterPicker.systemLayoutSizeFitting(view.bounds.size)
        if view.bounds.height > screenSize {
            chapterPicker.frame = .init(x: 0, y: 0, width: chapterPickerPreferredSize.width, height: 220.0)
        } else {
            chapterPicker.frame = .init(x: 0, y: 0, width: chapterPickerPreferredSize.width, height: 150.0)
        }
        
        taskChapter.inputAccessoryView = toolbar
        taskChapter.inputView = chapterPicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            taskImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        datePicker.preferredDatePickerStyle = .wheels
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(datePickerDoneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
        let datePickerPreferredSize = datePicker.systemLayoutSizeFitting(view.bounds.size)
        if view.bounds.height > screenSize {
            datePicker.frame = .init(x: 0, y: 0, width: datePickerPreferredSize.width, height: 220.0)
        } else {
            datePicker.frame = .init(x: 0, y: 0, width: datePickerPreferredSize.width, height: 150.0)
        }
        datePicker.datePickerMode = .dateAndTime
        timerLabel.inputAccessoryView = toolbar
        timerLabel.inputView = datePicker
    }
    
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        let horizontalStack = UIStackView(arrangedSubviews: [returnButton, saveButton])
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = UIConstants.horizontalStackSpacing
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        taskImage.image = UIImage(named: "")
        taskImage.translatesAutoresizingMaskIntoConstraints = false
        let imageViewWidthConstraint = NSLayoutConstraint(item: taskImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.bounds.width / 2)
        let imageViewHeightConstraint = NSLayoutConstraint(item: taskImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.bounds.width / 2)
        taskImage.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        
        timerTitle.text = TaskScreen.deadline.rawValue.localized
        timerTitle.textAlignment = .left
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        if timerLabel.text != TaskScreen.deadline.rawValue.localized {
            timerLabel.textColor = .black
        }
        
        taskChapterTitle.text = TaskScreen.chapter.rawValue.localized
        taskChapterTitle.textAlignment = .left
        
        if taskChapter.text != TaskScreen.chapter.rawValue.localized {
            taskChapter.textColor = .black
        }
        
        taskDescriptionTitle.text = TaskScreen.description.rawValue.localized
        taskDescriptionTitle.textAlignment = .left
        
        taskDescription.isScrollEnabled = true
        taskDescription.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        taskDescription.layer.borderColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.00).cgColor ;
        taskDescription.layer.borderWidth = 2.0;
        taskDescription.layer.cornerRadius = 15.0;
        
        let verticalStack = UIStackView(arrangedSubviews: [taskLabel, timerTitle, timerLabel, taskChapterTitle, taskChapter, taskDescriptionTitle, taskDescription, taskImage, setImageButton, horizontalStack])
        scrollView.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15.0).isActive = true
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
    
    @objc func returnButtonPressed(){
        print("Delete")
        navigationController?.dismiss(animated: true)
    }

    @objc func saveButtonPressed(){
        
    }
    
    @objc func imageSetButtonPressed(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func chapterDoneButtonPressed() {
        self.view.endEditing(true)
    }
    
    @objc func datePickerDoneButtonPressed() {
        dateFormatter.dateFormat = "HH:mm dd.MM.YYYY"
        timerLabel.text = "\(dateFormatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
}
