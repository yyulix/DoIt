//
//  OnboardingCell.swift
//  DoIt
//
//  Created by Данил Швец on 28.11.2021.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    private struct UIConstants {
        static let titleTextFontSizeNormal = 32.0
        static let titleTextFontSizeSmall = 28.0
        static let titleTextHeightNormal = 50.0
        static let titleTextHeightSmall = 35.0
        static let labelTextFontSizeNormal = 24.0
        static let labelTextFontSizeSmall = 20.0
        static let labelTextHeightSmall = 80.0
        static let labelTextHeightNormal = 100.0
        static let paddingTop = 100.0
        static let verticalStackPaddingLeft = 30.0
        static let verticalStackPaddingBottom = -10.0
        static let verticalStackSpacing = 12.0
    }
    
    private let screenSize: CGFloat = 667.0
    private let closeButton = CloseButton(target: self, action: #selector(closeButtonPressed))
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        return image
    }()
    
    private var titleText: UITextView = {
       let titleText = UITextView()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.font = UIFont.boldSystemFont(ofSize: UIConstants.titleTextFontSizeNormal)
        titleText.textColor = UIColor.black
        titleText.textAlignment = .center
        titleText.isEditable = false
        titleText.isScrollEnabled = false
        titleText.backgroundColor = .white
        return titleText
    }()
    
    private var labelText: UITextView = {
       let labelText = UITextView()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont.systemFont(ofSize: UIConstants.labelTextFontSizeNormal)
        labelText.textColor = UIColor.gray
        labelText.textAlignment = .center
        labelText.isEditable = false
        labelText.isScrollEnabled = false
        labelText.backgroundColor = .white
        return labelText
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureVerticalStack()
    }
    
    func fillOnboardingData(onboarding: Onboarding) {
        image.image = UIImage(named: onboarding.image ?? "")
        titleText.text = onboarding.titleText ?? "Title"
        labelText.text = onboarding.labelText ?? "Label"
    }
    
    func configureVerticalStack() {
        if bounds.height <= screenSize {
            titleText.font = UIFont.boldSystemFont(ofSize: UIConstants.titleTextFontSizeSmall)
            titleText.heightAnchor.constraint(equalToConstant: UIConstants.titleTextHeightSmall).isActive = true
            labelText.font = UIFont.boldSystemFont(ofSize: UIConstants.labelTextFontSizeSmall)
            labelText.heightAnchor.constraint(equalToConstant: UIConstants.labelTextHeightSmall).isActive = true
        } else {
            titleText.font = UIFont.boldSystemFont(ofSize: UIConstants.titleTextFontSizeNormal)
            titleText.heightAnchor.constraint(equalToConstant: UIConstants.titleTextHeightNormal).isActive = true
            labelText.font = UIFont.boldSystemFont(ofSize: UIConstants.labelTextFontSizeNormal)
            labelText.heightAnchor.constraint(equalToConstant: UIConstants.labelTextHeightNormal).isActive = true
        }
        let verticalStack = UIStackView(arrangedSubviews: [closeButton, image, titleText, labelText])
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
        verticalStack.backgroundColor = .white
        verticalStack.spacing = UIConstants.verticalStackSpacing
        addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.verticalStackPaddingLeft).isActive = true
        verticalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIConstants.verticalStackPaddingLeft).isActive = true
        verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.paddingTop).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.verticalStackPaddingBottom).isActive = true
    }
    
    @objc func closeButtonPressed(){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

