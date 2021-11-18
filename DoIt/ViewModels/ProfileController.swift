//
//  ProfileController.swift
//  DoIt
//
//  Created by Yulia on 17.11.2021.
//

import UIKit
import FirebaseStorage

class ProfileController: UIViewController {

    private struct UIConstants {
        static let paddingTop = 50.0
    }

    private let email: String

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = email
        return label
    }()

    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .white
        navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .white
        configureInputsStackView()
    }

    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [emailLabel])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.paddingTop).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
