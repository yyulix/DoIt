//
//  RegistrationController.swift
//  DoIt
//
//  Created by Y u l i a on 22.10.2021.
//

import UIKit

class RegistrationController: UIViewController {

    private struct UIConstants {
        static let spacing = 12.0
        static let paddingTop = 44.0
    }

    // MARK: - Public Property

    // MARK: - Private Property

    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: registrationStrings.username.rawValue.localized)
    private lazy var envelopeInputView = InputField(labelImage: UIImage.AuthIcons.envelopeIcon, placeholderText: registrationStrings.mailAddress.rawValue.localized)
    private lazy var passwordInputView : InputField = {
        lazy var passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: registrationStrings.passwordInputView.rawValue.localized)
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }()
    private lazy var retypePasswordInputView : InputField = {
        let retypePasswordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: registrationStrings.retypePasswordInput.rawValue.localized)
        retypePasswordInput.textField.isSecureTextEntry = true
        return retypePasswordInput
    }()
    private lazy var registerButton = CustomRoundedButton(title: registrationStrings.registerButton.rawValue.localized)
    private lazy var signInButton = AttributedCustomButton(firstPart: registrationStrings.signInButtonFirstPart.rawValue.localized, secondPart: registrationStrings.signInButtonSecondPart.rawValue.localized)

    // MARK: - Public Methods

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .white
        navigationItem.title = registrationStrings.navigationTitle.rawValue.localized
        view.backgroundColor = .white
        configureInputsStackView()
    }

    // MARK: - Private Methods

    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameInputView, envelopeInputView, passwordInputView, retypePasswordInputView, registerButton, signInButton])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.paddingTop + UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
