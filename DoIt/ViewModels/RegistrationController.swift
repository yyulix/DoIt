//
//  RegistrationController.swift
//  DoIt
//
//  Created by Y u l i a on 22.10.2021.
//

import UIKit
import PopupDialog

class RegistrationController: UIViewController {

    private struct UIConstants {
        static let spacing = 12.0
        static let popupCornerRadius : Float = 25.0
        static let blurRadius = 10.0
    }

    // MARK: - Public Property

    // MARK: - Private Property

    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: AuthStrings.username.rawValue.localized)
    private lazy var envelopeInputView = InputField(labelImage: UIImage.AuthIcons.envelopeIcon, placeholderText: AuthStrings.email.rawValue.localized)
    private lazy var passwordInputView : InputField = {
        lazy var passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: AuthStrings.password.rawValue.localized)
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }()
    private lazy var retypePasswordInputView : InputField = {
        let retypePasswordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: AuthStrings.retypePassword.rawValue.localized)
        retypePasswordInput.textField.isSecureTextEntry = true
        return retypePasswordInput
    }()
    
    private lazy var registerButton : CustomRoundedButton = {
        let button = CustomRoundedButton(title: AuthStrings.signUp.rawValue.localized)
        button.button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInButton : UIButton = {
        let button = AttributedCustomButton(firstPart: AuthStrings.notSignedUp.rawValue.localized, secondPart: AuthStrings.signIn.rawValue.localized)
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Methods

    @objc func signIn(){
        let controller = AuthenticationController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Selectors

    @objc func signUp() {
        guard let email = envelopeInputView.textField.text else {return}
        guard let username = usernameInputView.textField.text?.lowercased() else {return}
        guard let password = passwordInputView.textField.text else {return}
        guard let retypePassword = retypePasswordInputView.textField.text else {return}
        if password != retypePassword {
            let title = AuthStrings.signUpSuccessful.rawValue.localized
            let message = AuthStrings.passwordMismatched.rawValue.localized

            var popup : PopupDialog = {
               let pop = PopupDialog(title: title, message: message)
                let btn = CancelButton(title: "Ok") {}
                pop.addButton(btn)
                return pop
            }()
            self.present(popup, animated: true, completion: nil)
            return
        }
        AuthService.shared.signUp(email: email, username: username, password: password) { (result) in
            switch result {
            case .success:

                let title = AuthStrings.signUpSuccessful.rawValue.localized
                let message = AuthStrings.welcome.rawValue.localized

                lazy var popup : PopupDialog = {
                   let pop = PopupDialog(title: title, message: message)
                    let btn = CancelButton(title: AuthStrings.invitation.rawValue.localized) {
                        let profileView = ProfileController(email: email)
                        self.present(profileView, animated: true, completion: nil)
                    }
                    pop.addButton(btn)
                    return pop
                }()

                self.present(popup, animated: true, completion: nil)
            case .failure(let error):
                
                let title = AuthStrings.signInUnsuccessful.rawValue.localized
                let message = error.localizedDescription

                lazy var popup : PopupDialog = {
                   let pop = PopupDialog(title: title, message: message)
                    let btn = CancelButton(title: AuthStrings.accept.rawValue.localized) {}
                    pop.addButton(btn)
                    return pop
                }()

                self.present(popup, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .white
        navigationItem.title = AuthStrings.headerSignUp.rawValue.localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        configureInputsStackView()
        configurePopUpView()
    }

    // MARK: - Private Methods

    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameInputView, envelopeInputView, passwordInputView, retypePasswordInputView, registerButton, signInButton])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }

    private func configurePopUpView() {

        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.blurRadius = UIConstants.blurRadius
        overlayAppearance.blurEnabled = true

        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.backgroundColor = UIColor.white
        containerAppearance.cornerRadius = UIConstants.popupCornerRadius

        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.backgroundColor = .white
        dialogAppearance.titleColor = UIColor.AppColors.accentColor
        dialogAppearance.titleTextAlignment = .center
        dialogAppearance.messageColor = UIColor(white: 0.6, alpha: 1)
        dialogAppearance.messageTextAlignment = .center
    }
}
