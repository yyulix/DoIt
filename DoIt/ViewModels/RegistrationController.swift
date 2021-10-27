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
        static let paddingTop = 44.0 + (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }

    // MARK: - Public Property

    // MARK: - Private Property

    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: "RegistrationController.usernameInputView".localized)
    private lazy var envelopeInputView = InputField(labelImage: UIImage.AuthIcons.envelopeIcon, placeholderText: "RegistrationController.envelopeInputView".localized)
    private var passwordInputView : InputField {
        lazy var passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: "RegistrationController.passwordInputView".localized)
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }
    private var retypePasswordInputView : InputField {
        lazy var retypePasswordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: "RegistrationController.retypePasswordInputView".localized)
        retypePasswordInput.textField.isSecureTextEntry = true
        return retypePasswordInput
    }
    private lazy var registerButton = CustomRoundedButton(title: "RegistrationController.registerButton".localized)
    private lazy var signInButton = AttributedCustomButton(firstPart: "RegistrationController.signInButton.firstPart".localized, secondPart: "RegistrationController.signInButton.secondPart".localized)

    // MARK: - Public Methods

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .white
        navigationItem.title = "RegistrationController.header".localized
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
