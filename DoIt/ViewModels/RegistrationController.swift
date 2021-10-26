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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInputsStackView()
    }
    
    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: NSLocalizedString("RegistrationController.usernameInputView", comment: ""))
    private lazy var envelopeInputView = InputField(labelImage: UIImage.AuthIcons.envelopeIcon, placeholderText: NSLocalizedString("RegistrationController.envelopeInputView", comment: ""))
    private lazy var passwordInputView = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: NSLocalizedString("RegistrationController.passwordInputView", comment: ""))
    private lazy var retypePasswordInputView = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: NSLocalizedString("RegistrationController.retypePasswordInputView", comment: ""))
    private lazy var registerButton = CustomRoundedButton(title: NSLocalizedString("RegistrationController.registerButton", comment: ""))

//    private lazy var registerButton = CustomRoundedButton(title: NSLocalizedString("a", comment: ""))
    private lazy var signInButton = AttributedCustomButton(firstPart: NSLocalizedString("RegistrationController.signInButton.firstPart", comment: ""), secondPart: NSLocalizedString("RegistrationController.signInButton.secondPart", comment: ""))
    private lazy var header_ = Header(title: NSLocalizedString("RegistrationController.header", comment: ""))

    func configureInputsStackView() {
        view.backgroundColor = .white
        
        passwordInputView.textField.isSecureTextEntry = true
        retypePasswordInputView.textField.isSecureTextEntry = true
        
        let stack = UIStackView(arrangedSubviews: [header_, usernameInputView, envelopeInputView, passwordInputView, retypePasswordInputView, registerButton, signInButton])
        
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
   
    }
    
}
