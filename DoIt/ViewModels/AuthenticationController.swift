//
//  AuthenticationController.swift
//  DoIt
//
//  Created by Данил Швец on 29.10.2021.
//

import UIKit
import PopupDialog

class AuthenticationController: UIViewController {

    private struct UIConstants {
        static let spacing = 12.0
        static let popupCornerRadius : Float = 25.0
        static let blurRadius = 10.0
    }

    private lazy var envelopeInputView = InputField(labelImage: UIImage.AuthIcons.envelopeIcon, placeholderText: AuthStrings.email.rawValue.localized)
    private lazy var passwordInputView : InputField = {
        let passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: AuthStrings.password.rawValue.localized)
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }()

    private lazy var signInButton : CustomRoundedButton = {
        let button = CustomRoundedButton(title: AuthStrings.signIn.rawValue.localized)
        button.button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()

    private lazy var signUpButton : UIButton = {
        let button = AttributedCustomButton(firstPart: AuthStrings.notSignedUp.rawValue.localized, secondPart: AuthStrings.signUp.rawValue.localized)
        button.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigation()
        configureInputsStackView()
        configurePopUpView()
    }

    @objc func SignUp(){
            let controller = RegistrationController()
            navigationController?.pushViewController(controller, animated: true)
    }

    @objc func signIn() {
        guard let email = envelopeInputView.textField.text else {return}
                guard let password = passwordInputView.textField.text else {return}
        AuthService.shared.signIn(email: email, password: password) { (result) in
            switch result {
            case .success:

                let title = AuthStrings.signInSuccessful.rawValue.localized
                let message = AuthStrings.welcome.rawValue.localized

                lazy var popup : PopupDialog = {
                   let pop = PopupDialog(title: title, message: message)
                    let button = CancelButton(title: AuthStrings.invitation.rawValue.localized) {
                        let profileView = ProfileController(email: email)
                        self.present(profileView, animated: true, completion: nil)
                    }
                    pop.addButton(button)
                    return pop
                }()

                self.present(popup, animated: true, completion: nil)
            case .failure(let error):

                let title = AuthStrings.signInUnsuccessful.rawValue.localized
                let message = error.localizedDescription

                lazy var popup : PopupDialog = {
                   let pop = PopupDialog(title: title, message: message)
                    let button = CancelButton(title: AuthStrings.accept.rawValue.localized) {}
                    pop.addButton(button)
                    return pop
                }()

                self.present(popup, animated: true, completion: nil)
            }
        }
    }

    func configureNavigation() {
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.title = AuthStrings.headerSignIn.rawValue.localized
    }

    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [envelopeInputView, passwordInputView, signInButton, signUpButton])
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
