//
//  CustomUIElementsTask.swift
//  DoIt
//
//  Created by Данил Швец on 01.12.2021.
//

import UIKit

final class TaskButton: UIView {

    private struct UIConstants {
        static let height = 50.0
        static let width = 200.0
    }

    // MARK: - Public Properties

    // MARK: - Private Properties

    // MARK: - Initializers

    init(imageName: UIImage?, target: Any? = nil, action: Selector? = nil, width: CGFloat? = UIConstants.width, height: CGFloat? = UIConstants.height, color: UIColor? = UIColor.AppColors.accentColor) {

        super.init(frame: .zero)

        heightAnchor.constraint(equalToConstant: height ?? UIConstants.height).isActive = true

        
        let button = UIButton(type: .system)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        button.layer.cornerRadius = UIConstants.height / 2;
        button.backgroundColor = color
        button.tintColor = .white
        button.setImage(imageName, for: .normal)
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: width ?? UIConstants.width).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    // MARK: - Private methods
}
