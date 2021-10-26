//
//  Components.swift
//  DoIt
//
//  Created by Yulia on 22.10.2021.
//

import UIKit

final class InputField: UIView, UITextFieldDelegate {

    // MARK: - Public Properties
    
    public lazy var textField = UITextField()
    
    // MARK: - Private Properties
    
    private struct UIConstants {
        static let height = 50.0
        static let width = 200.0
        
        static let iconWidth = 20.0
        static let iconHeight = 20.0
        
        static let paddingLeft = 28.0
        static let paddingRight = -28.0
        static let paddingBottom = -8.0
        
        static let space = 8.0
        
        static let dividerWidth = 1.0
    }
    
    // MARK: - Initializers
    
    init(labelImage: UIImage? = nil, keyboardType: UIKeyboardType = .default, placeholderText: String) {
        super.init(frame: .zero)
        
        heightAnchor.constraint(equalToConstant: UIConstants.height).isActive = true
        
        let icon = UIImageView()
        addSubview(icon)
        
        icon.image = labelImage
        icon.tintColor = UIColor.accentColor
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: UIConstants.iconWidth).isActive = true
        icon.heightAnchor.constraint(equalToConstant: UIConstants.iconHeight).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.paddingLeft).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
        
        textField = UITextField()
        textField.autocorrectionType = .no
        addSubview(textField)

        textField.placeholder = placeholderText
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: UIConstants.space).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor, constant: UIConstants.paddingRight).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
                
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.accentColor
        addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        dividerView.heightAnchor.constraint(equalToConstant: UIConstants.dividerWidth).isActive = true
        dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.paddingLeft).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor, constant: UIConstants.paddingRight).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods

    public func seccc() {
        textField.isSecureTextEntry = true
    }
}

final class CustomRoundedButton: UIView {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private struct UIConstants {
        static let height = 50.0
        static let width = 200.0
    }

    // MARK: - Initializers
    
    init(title: String, target: Any? = nil, action: Selector? = nil) {
        
        super.init(frame: .zero)
        
        heightAnchor.constraint(equalToConstant: UIConstants.height).isActive = true
        
        let button = UIButton(type: .system)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        button.layer.cornerRadius = UIConstants.height / 2;
        button.backgroundColor = UIColor.systemTeal
        button.setTitle(title, for: .normal)
        button.tintColor = .white

        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIConstants.width).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
}

final class AttributedCustomButton: UIButton {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private struct UIConstants {
        static let fontSize = 16.0
    }
    
    // MARK: - Initializers
    
    init(firstPart: String, secondPart: String) {
        super.init(frame: .zero)
        
        let attributedTitle = NSMutableAttributedString(
            string: firstPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIConstants.fontSize),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        attributedTitle.append(NSAttributedString(
            string: secondPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIConstants.fontSize),
                NSAttributedString.Key.foregroundColor: UIColor.accentColor
            ]
        ))

        setAttributedTitle(attributedTitle, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
}

final class Header: UIView {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    private struct UIConstants {
        static let height = 80.0
        static let paddingBottom = -8.0
        static let paddingLeft = 28.0
    }
    
    // MARK: - Initializers
    
    init(title: String) {
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: UIConstants.height).isActive = true
        backgroundColor = UIColor.accentColor
        
        let label = UILabel()
        addSubview(label)
        
        label.textColor = .white

        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.paddingLeft).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.paddingBottom).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
}
