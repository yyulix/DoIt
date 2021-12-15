//
//  AuthenticationController.swift
//  DoIt
//
//  Created by Данил Швец on 29.10.2021.
//

import UIKit

class SignInController: UIViewController {
    
    private struct UIConstants {
        static let spacing = 12.0
    }
    
    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: AuthStrings.username.rawValue.localized)
    private lazy var passwordInputView : InputField = {
        let passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: AuthStrings.password.rawValue.localized)
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }()
    private lazy var signInButton = CustomRoundedButton(title: AuthStrings.signIn.rawValue.localized, target: self, action: #selector(signInButtonPressed(_:)))
    private lazy var signUpButton: AttributedCustomButton = {
        let button = AttributedCustomButton(firstPart: AuthStrings.notSignedUp.rawValue.localized, secondPart: AuthStrings.signUp.rawValue.localized)
        button.addTarget(self, action: #selector(signUpButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.authResultModel.bind { [weak self] authResult in
            switch authResult {
            case .success:
                print("SignIn successed")
                self?.presentTabBar()
            case .failure(let error):
                print("SignIn was failured: ", error.localizedDescription)
            case .none:
                return
            }
        }
        configureView()
    }

    // MARK: - Private Methods
    
    private func configureView() {
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .systemBackground
        navigationItem.title = AuthStrings.headerSignIn.rawValue.localized
        configureInputsStackView()
    }
    
    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameInputView, passwordInputView, signInButton, signUpButton])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    private func presentTabBar() {
        let tabbarController = CustomTabBarController()
        tabbarController.modalPresentationStyle = .fullScreen
        present(tabbarController, animated: true)
    }
    
    @objc private func signInButtonPressed(_ sender: UIButton) {
        self.viewModel.signIn(email: usernameInputView.textField.text, password: passwordInputView.textField.text)
    }
    
    @objc private func signUpButtonPressed(_ sender: UIButton) {
        navigationController?.pushViewController(SignUpController(), animated: true)
    }
}
