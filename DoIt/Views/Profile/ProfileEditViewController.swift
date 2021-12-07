//
//  ProfileEditViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 20.11.2021.
//

import Foundation
import UIKit

final class ProfileEditViewController: UIViewController {
    // MARK: - Properties
    
    private struct Constants {
        static let offset: CGFloat = 8
        
        static let profileImageCornerRadius: CGFloat = 12
        static let profileImageWidth: CGFloat = 100
        
        static let nameLabelSizeOfFont: CGFloat = 16
        
        static let loginLabelSizeOfFont: CGFloat = 12
        
        static let stackViewTopOffset: CGFloat = 16
        static let stackViewSpacing: CGFloat = 4
        static let stackViewSpacingAfterChangeButton: CGFloat = 0
        static let stackViewSpacingAfterHints: CGFloat = -6
        
        static let hintLabelSizeOfFont: CGFloat = 12
        
        static let offsetForKeyboard: CGFloat = 15
        
        static let heightOfTextView: CGFloat = 200
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = Constants.profileImageCornerRadius
        image.layer.masksToBounds = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: Constants.profileImageWidth).isActive = true
        return image
    }()
    
    private lazy var changePhotoButton: AttributedCustomButton = {
        let button = AttributedCustomButton(firstPart: "", secondPart: ProfileEditString.newPhoto.rawValue.localized)
        button.addTarget(self, action: #selector(didTapChangeProfileImage), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameInputField: InputField = {
        let field = InputField(labelImage: nil, keyboardType: .default, placeholderText: ProfileEditString.namePlaceholder.rawValue.localized)
        field.textField.delegate = self
        return field
    }()
    
    private lazy var hintForNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.hintLabelSizeOfFont)
        label.textColor = .secondaryLabel
        label.text = ProfileEditString.nameHint.rawValue.localized
        return label
    }()
    
    private lazy var loginInputField: InputField = {
        let field = InputField(labelImage: nil, keyboardType: .default, placeholderText: ProfileEditString.loginPlaceholder.rawValue.localized)
        field.textField.delegate = self
        return field
    }()
    
    private lazy var hintForLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.hintLabelSizeOfFont)
        label.textColor = .secondaryLabel
        label.text = ProfileEditString.loginHint.rawValue.localized
        return label
    }()
    
    private lazy var summaryTextView: InputBox = {
        let box = InputBox(maxHeight: Constants.heightOfTextView, placeholder: ProfileEditString.summeryPlaceholder.rawValue.localized)
        box.textView.delegate = self
        return box
    }()
    
    private lazy var hintForSummaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.hintLabelSizeOfFont)
        label.textColor = .secondaryLabel
        label.text = ProfileEditString.summaryHint.rawValue.localized
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let subviews = [profileImageView, changePhotoButton, nameInputField, hintForNameLabel, loginInputField, hintForLoginLabel, summaryTextView, hintForSummaryLabel]
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.setCustomSpacing(Constants.stackViewSpacingAfterChangeButton, after: changePhotoButton)
        stackView.setCustomSpacing(Constants.stackViewSpacingAfterHints, after: hintForNameLabel)
        return stackView
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.ProfileEditIcons.doneIcon, for: .normal)
        button.addTarget(self, action: #selector(doneEditing), for: .touchUpInside)
        button.tintColor = .AppColors.navigationTextColor
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    private let keyboardManager = KeyboardManager.shared
    private var login: String = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: keyboardManager, action: #selector(keyboardManager.dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        view.snapshotView(afterScreenUpdates: true)
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configure(login: String, profileImage: UIImage?, summeryText: String?) {
        self.login = login
        profileImageView.image = profileImage
        summaryTextView.text = summeryText
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationController()
        layoutScrollView()
        layoutStackView()
        layoutWidthInputFields()
    }
    
    private func configureNavigationController() {
        navigationItem.title = ProfileEditString.header.rawValue.localized
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func layoutScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func layoutStackView() {
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.stackViewTopOffset).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    private func layoutWidthInputFields() {
        nameInputField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        loginInputField.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        summaryTextView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
}

extension ProfileEditViewController {
    @objc
    private func doneEditing() {
        
    }
}

// MARK: - Change Image

extension ProfileEditViewController {
    @objc
    private func didTapChangeProfileImage() {
        present(imagePickerController, animated: true, completion: nil)
    }
}

extension ProfileEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImageView.image = image
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Text Labels Delegate

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardManager.scrollViewToLabel(textField, view: view, scrollView: scrollView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameInputField.textField {
            loginInputField.textField.becomeFirstResponder()
        } else if textField == loginInputField.textField {
            summaryTextView.textView.becomeFirstResponder()
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        keyboardManager.scrollViewToDefault(scrollView: scrollView)
    }
}

// MARK: - Text Views Delegate

extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == summaryTextView.textView {
            summaryTextView.removePlaceholder()
        }
        keyboardManager.scrollViewToLabel(textView, view: view, scrollView: scrollView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        keyboardManager.scrollViewToLabel(textView, view: view, scrollView: scrollView, animated: false)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == summaryTextView.textView {
            summaryTextView.updateLayout()
        }
        keyboardManager.scrollViewToLabel(textView, view: view, scrollView: scrollView)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        if textView == summaryTextView.textView {
            summaryTextView.setPlaceholder()
        }
        keyboardManager.scrollViewToDefault(scrollView: scrollView)
    }
}

extension ProfileEditViewController: UIScrollViewDelegate {  }
