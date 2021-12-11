//
//  CustomUIElementsOnboarding.swift
//  DoIt
//
//  Created by Данил Швец on 28.11.2021.
//

import UIKit

final class CloseButton: UIView {

    private struct UIConstants {
        static let height = 20.0
        static let width = 20.0
    }

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    init(target: Any? = nil, action: Selector? = nil) {

        super.init(frame: .zero)

        heightAnchor.constraint(equalToConstant: UIConstants.height).isActive = true

        let button = UIButton(type: .system)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        button.layer.cornerRadius = UIConstants.height / 2
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .lightGray

        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIConstants.width).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    // MARK: - Private methods

}
