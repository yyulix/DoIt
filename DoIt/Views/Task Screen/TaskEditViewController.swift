//
//  TaskEditViewController.swift
//  DoIt
//
//  Created by Данил Швец on 01.12.2021.
//

import UIKit

class TaskEditViewController: UIViewController {
    
    private struct UIConstants {
        static let boldFontSize = 28.0
        static let normalFontSize = 24.0
        static let navigationBarFontSize = 26.0
        static let stackPadding = 20.0
        static let verticalStackSpacing = 10.0
        static let horizontalStackSpacing = 20.0
        static let verticalStackTopSpacing = 15.0
        static let imageCornerRadius = 12.0
        static let pickerHeightMultiplier = 0.3
    }
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    private lazy var chapterPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private lazy var colorPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var taskLabel: InputField = {
        let label = InputField(labelImage: nil, keyboardType: .default, placeholderText: TaskScreen.taskName.rawValue.localized)
        label.textField.font = UIFont(name: "Helvetica Neue Bold", size: UIConstants.navigationBarFontSize)
        label.textField.textAlignment = .center
        return label
    }()
    
    private lazy var timerTitle: UILabel = getTitleLabel(title: TaskScreen.deadline.rawValue.localized)

    private lazy var timerLabel: UITextField = getTextField(placeholder: TaskScreen.deadlineText.rawValue.localized)
    
    private lazy var taskDescriptionTitle: UILabel = getTitleLabel(title: TaskScreen.description.rawValue.localized)
    
    private lazy var taskDescription: InputBox = {
        let taskDescription = InputBox(maxHeight: 200, placeholder: nil)
        taskDescription.textView.delegate = self
        return taskDescription
    }()
    
    private lazy var taskChapterTitle: UILabel = getTitleLabel(title: TaskScreen.chapter.rawValue.localized)
    
    private lazy var taskChapter: UITextField = getTextField(placeholder: TaskScreen.chapterText.rawValue.localized)
    
    private lazy var taskColorTitle: UILabel = getTitleLabel(title: TaskScreen.color.rawValue.localized)
    
    private lazy var taskColor: UITextField = getTextField(placeholder: TaskScreen.colorText.rawValue.localized)
    
    private lazy var taskImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = UIConstants.imageCornerRadius
        image.layer.masksToBounds = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: view.bounds.width / 2).isActive = true
        return image
    }()
    
    private lazy var taskImageViewContainter: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var returnButton = CustomRoundedButton(title: TaskScreen.returnButton.rawValue.localized, target: self, action: #selector(returnButtonPressed), width: view.bounds.width / 3, color: .AppColors.greyColor)
    
    private lazy var saveButton = CustomRoundedButton(title: TaskScreen.saveButton.rawValue.localized, target: self, action: #selector(saveButtonPressed), width: view.bounds.width / 3, color: UIColor.AppColors.accentColor)
    
    private lazy var setImageButton = CustomRoundedButton(title: TaskScreen.changePhotoButton.rawValue.localized, target: self, action: #selector(imageSetButtonPressed), width: view.bounds.width / 2, color: .AppColors.purpleColor)
    
    private let keyboardManager = KeyboardManager.shared
    
    private let dateFormatter: DateFormatter = {
        let dateFormateer = DateFormatter()
        dateFormateer.dateFormat = "HH:mm dd.MM.YYYY"
        return dateFormateer
    }()
    
    private let chapters = (0...(TaskCategory.chaptersCount - 1)).map({ TaskCategory(index: $0) })
    
    private let colors: [(color: UIColor, stringColor: String)] = [
        (.TaskColors.black, TaskScreen.blackColor.rawValue.localized),
        (.TaskColors.white, TaskScreen.whiteColor.rawValue.localized),
        (.TaskColors.red, TaskScreen.redColor.rawValue.localized),
        (.TaskColors.green, TaskScreen.greenColor.rawValue.localized),
        (.TaskColors.blue, TaskScreen.blueColor.rawValue.localized),
        (.TaskColors.yellow, TaskScreen.yellowColor.rawValue.localized),
        (.TaskColors.gray, TaskScreen.grayColor.rawValue.localized),
        (.TaskColors.purple, TaskScreen.purpleColor.rawValue.localized),
        (.TaskColors.orange, TaskScreen.orangeColor.rawValue.localized),
        (.TaskColors.magenta, TaskScreen.magentaColor.rawValue.localized),
        (.TaskColors.cyan, TaskScreen.cyanColor.rawValue.localized),
        (.TaskColors.brown, TaskScreen.brownColor.rawValue.localized)
    ]
    
    var taskModel: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: keyboardManager, action: #selector(keyboardManager.dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        configureView()
    }
    
    private func configureTask() {
        guard let taskModel = taskModel else { return }
        taskImageViewContainter.isHidden = taskModel.image == nil
        taskLabel.textField.text = taskModel.title
        taskChapter.text = TaskCategory(index: taskModel.chapterId).chapter.title
        taskDescription.text = taskModel.description
        taskImage.image = taskModel.image
        guard let deadline = taskModel.deadline else { return }
        timerLabel.text = dateFormatter.string(from: deadline)
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        layoutScrollView()
        layoutContentView()
        layoutImageView()
        configureStacks()
        configurePicker(picker: datePicker, toView: timerLabel, action: #selector(datePickerDoneButtonPressed))
        configurePicker(picker: chapterPicker, toView: taskChapter, action: #selector(chapterDoneButtonPressed))
        configurePicker(picker: colorPicker, toView: taskColor, action: #selector(colorDoneButtonPressed))
        configureTask()
    }
    
    private func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func layoutContentView() {
        scrollView.addSubview(contentView)
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor).isActive = true
    }
    
    private func configureStacks() {
        let verticalStack = UIStackView(arrangedSubviews: [taskLabel, timerTitle, timerLabel, taskChapterTitle, taskChapter, taskColorTitle, taskColor, taskDescriptionTitle, taskDescription, taskImageViewContainter, setImageButton])
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
        verticalStack.spacing = UIConstants.verticalStackSpacing
        verticalStack.setCustomSpacing(UIConstants.stackPadding, after: taskDescription)
        
        let horizontalStack = UIStackView(arrangedSubviews: [returnButton, saveButton])
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .fill
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = UIConstants.horizontalStackSpacing
        
        [verticalStack, horizontalStack].forEach { stack in
            contentView.addSubview(stack)
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: UIConstants.stackPadding).isActive = true
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -UIConstants.stackPadding).isActive = true
        }
        
        verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.verticalStackTopSpacing).isActive = true
        
        horizontalStack.topAnchor.constraint(greaterThanOrEqualTo: verticalStack.bottomAnchor, constant: UIConstants.verticalStackSpacing).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func layoutImageView() {
        taskImageViewContainter.addSubview(taskImage)
        taskImageViewContainter.heightAnchor.constraint(equalTo: taskImage.heightAnchor).isActive = true
        taskImage.centerYAnchor.constraint(equalTo: taskImageViewContainter.centerYAnchor).isActive = true
        taskImage.centerXAnchor.constraint(equalTo: taskImageViewContainter.centerXAnchor).isActive = true
    }
    
    private func configurePicker(picker: UIView, toView accessView: UITextField, action: Selector) {
        picker.frame = .init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * UIConstants.pickerHeightMultiplier)
        let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: action)
        toolbar.setItems([doneButton], animated: false)
        accessView.inputAccessoryView = toolbar
        accessView.inputView = picker
    }
    
    private func getTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.boldFontSize)
        label.text = title
        label.textAlignment = .left
        return label
    }
    
    private func getTextField(placeholder: String) -> UITextField {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = placeholder
        field.textAlignment = .center
        field.font = UIFont.systemFont(ofSize: UIConstants.normalFontSize)
        return field
    }
}

// MARK: - Image Picker Delegates

extension TaskEditViewController: UINavigationControllerDelegate {   }

extension TaskEditViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            imagePicker.dismiss(animated: true, completion: nil);
            return
        }
        taskImage.image = image
        taskImageViewContainter.isHidden = false
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Picker View Delegates

extension TaskEditViewController: UIPickerViewDelegate {   }

extension TaskEditViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == chapterPicker {
            return chapters[row].chapter.title
        } else {
            return colors[row].stringColor
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == chapterPicker {
            taskChapter.text = chapters[row].chapter.title
        } else {
            taskColor.text = colors[row].stringColor
            taskColor.textColor = colors[row].color
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == chapterPicker {
            return chapters.count
        } else {
            return colors.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - Text View Delegates

extension TaskEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        keyboardManager.scrollViewToLabel(textView, view: view, scrollView: scrollView, coordinatesCompareWith: contentView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        keyboardManager.scrollViewToLabel(textView, view: view, scrollView: scrollView, coordinatesCompareWith: contentView, animated: false)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == taskDescription.textView {
            taskDescription.updateLayout()
        }
        keyboardManager.scrollViewToLabel(textView, view: view, scrollView: scrollView, coordinatesCompareWith: contentView)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        keyboardManager.scrollViewToDefault(scrollView: scrollView)
    }
}

// MARK: - Actions

extension TaskEditViewController {
    @objc private func returnButtonPressed() {
        dismiss(animated: true)
    }

    @objc private func saveButtonPressed() {
        
    }
    
    @objc private func imageSetButtonPressed() {
        guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func chapterDoneButtonPressed() {
        view.endEditing(true)
    }
    
    @objc private func datePickerDoneButtonPressed() {
        timerLabel.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func colorDoneButtonPressed() {
        view.endEditing(true)
    }
}
