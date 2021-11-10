//
//  AuthenticationController.swift
//  DoIt
//
//  Created by Данил Швец on 29.10.2021.
//

import UIKit

class AuthenticationController: UIViewController {
    
    private struct UIConstants {
        static let spacing = 12.0
    }
    
    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: AuthStrings.username.rawValue.localized)
    private lazy var passwordInputView : InputField = {
        let passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: AuthStrings.password.rawValue.localized)
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }()
    private lazy var singInButton = CustomRoundedButton(title: AuthStrings.signIn.rawValue.localized)
    private lazy var signUpButton = AttributedCustomButton(firstPart: AuthStrings.notSignedUp.rawValue.localized, secondPart: AuthStrings.signUp.rawValue.localized)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigation()
        configureInputsStackView()
    }
    
    func configureNavigation() {
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.title = AuthStrings.headerSignIn.rawValue.localized
    }
    
    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameInputView, passwordInputView, singInButton, signUpButton])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
