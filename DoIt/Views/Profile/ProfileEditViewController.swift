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
        static let stackViewSpacing: CGFloat = 2
        static let stackViewSpacingAfterChangeButton: CGFloat = -24
        static let stackViewSpacingAfterHints: CGFloat = -8
        
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
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private var keyboardHeight: CGFloat = 0
    private var login: String = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        view.snapshotView(afterScreenUpdates: true)
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configure(with: ProfileEditModel) {
        login = with.login
        profileImageView.image = with.image
        summaryTextView.text = with.summery
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureNavigationController()
        layoutScrollView()
        layoutContentView()
        layoutStackView()
        layoutWidthInputFields()
    }
    
    private func configureNavigationController() {
        navigationItem.title = ProfileEditString.header.rawValue.localized
        navigationItem.rightBarButtonItem = doneButton
    }
    
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
    
    private func layoutStackView() {
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.stackViewTopOffset).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.offset).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.offset).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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

// MARK: - Actions with Keyboard

extension ProfileEditViewController {
    @objc
    private func keyboardWillShow(_ sender: Notification) {
        if let userInfo = (sender as NSNotification).userInfo {
            if let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                self.keyboardHeight = keyboardHeight
                NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            }
        }
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func scrollViewToInputLabel(textField: UIView, animated: Bool = true) {
        view.layoutIfNeeded()
        let fieldInScrollView = textField.convert(textField.bounds, to: view)
        let bottomOfTextField: CGFloat = fieldInScrollView.maxY
        let topOfKeyboard = view.frame.height - keyboardHeight
        if bottomOfTextField > topOfKeyboard {
            scrollView.setContentOffset(.init(x: 0, y: abs(topOfKeyboard - bottomOfTextField) + Constants.offsetForKeyboard), animated: animated)
        }
        view.layoutIfNeeded()
    }

    private func scrollViewToDefault() {
        scrollView.setContentOffset(.zero, animated: true)
    }
}

// MARK: - Text Labels Delegate

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollViewToInputLabel(textField: textField)
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
        scrollViewToDefault()
    }
}

// MARK: - Text Views Delegate

extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == summaryTextView.textView {
            summaryTextView.removePlaceholder()
        }
        scrollViewToInputLabel(textField: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        scrollViewToInputLabel(textField: textView, animated: false)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == summaryTextView.textView {
            summaryTextView.updateLayout()
        }
        scrollViewToInputLabel(textField: textView)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        if textView == summaryTextView.textView {
            summaryTextView.setPlaceholder()
        }
        scrollViewToDefault()
    }
}

extension ProfileEditViewController: UIScrollViewDelegate {  }
