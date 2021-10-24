//
//  AuthenticationController.swift
//  DoIt
//
//  Created by Данил Швец on 23.10.2021.
//

import UIKit

class AuthenticationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
    }
    
    private lazy var emailInputView = InputField(labelImage: UIImage(systemName: "person"), placeholderText: "Enter e-mail")
    private lazy var passwordInputView = InputField(labelImage: UIImage(systemName: "lock"), placeholderText: "Enter password", isSecureTextField: true)
    private lazy var loginButton = CustomRoundedButton(title: "Log In")
    private lazy var header_ = Header(title: "Authentication")
    
    func configureInterface() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [header_, emailInputView, passwordInputView, loginButton])
        
        stack.axis = .vertical
        stack.spacing = 12

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
   
    }
    
}

