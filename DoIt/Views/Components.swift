//
//  Components.swift
//  DoIt
//
//  Created by Yulia on 22.10.2021.
//

import UIKit

final class InputField: UIView, UITextFieldDelegate {

    init(labelImage: UIImage? = nil, keyboardType: UIKeyboardType = .default, placeholderText: String, isSecureTextField: Bool = false) {

        super.init(frame: .zero)
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let icon = UIImageView()
        addSubview(icon)
        
        icon.image = labelImage
        icon.tintColor = .systemTeal
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 28).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        let textField = UITextField()
        addSubview(textField)

        textField.placeholder = placeholderText
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -28).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        textField.isSecureTextEntry = isSecureTextField
        
        let dividerView = UIView()
        dividerView.backgroundColor = .systemTeal
        addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 28).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -28).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CustomRoundedButton: UIView {

    init(title: String, target: Any? = nil, action: Selector? = nil) {
        
        super.init(frame: .zero)
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let button = UIButton(type: .system)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        button.layer.cornerRadius = 25;
        button.backgroundColor = .systemTeal
        button.setTitle(title, for: .normal)
        button.tintColor = .white

        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AttributedCustomButton: UIButton {
    
    init(firstPart: String, secondPart: String) {
        super.init(frame: .zero)
        
        let attributedTitle = NSMutableAttributedString(
            string: firstPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        attributedTitle.append(NSAttributedString(
            string: secondPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.systemTeal
            ]
        ))

        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class Header: UIView {
    
    init(title: String) {
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        backgroundColor = .systemTeal
        
        let label = UILabel()
        addSubview(label)
        
        label.textColor = .white

        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 28).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
