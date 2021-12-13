//
//  OnboardingCell.swift
//  DoIt
//
//  Created by Данил Швец on 28.11.2021.
//

import UIKit

protocol OnboardingCellDelegate: AnyObject {
    func closeButtonPressed()
}

class OnboardingCell: UICollectionViewCell {
    
    private struct UIConstants {
        static let titleTextFontSizeNormal = 32.0
        static let titleTextFontSizeSmall = 28.0
        static let titleTextHeightNormal = 50.0
        static let titleTextHeightSmall = 35.0
        static let labelTextFontSizeNormal = 24.0
        static let labelTextFontSizeSmall = 20.0
        static let labelTextHeightSmall = 80.0
        static let labelTextHeightNormal = 180.0
        static let closeButtonSize = 20.0
        static let padding = 30.0
        static let topPadding = 10.0
        static let verticalStackSpacing = 5.0
    }
    
    private let screenSize: CGFloat = 667.0
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .systemBackground
        return image
    }()
    
    private var titleText: UITextView = {
       let titleText = UITextView()
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.font = UIFont.boldSystemFont(ofSize: UIConstants.titleTextFontSizeNormal)
        titleText.textAlignment = .center
        titleText.isEditable = false
        titleText.isScrollEnabled = false
        titleText.backgroundColor = .systemBackground
        return titleText
    }()

    private var labelText: UITextView = {
       let labelText = UITextView()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont.systemFont(ofSize: UIConstants.labelTextFontSizeNormal)
        labelText.textColor = .secondaryLabel
        labelText.textAlignment = .center
        labelText.isEditable = false
        labelText.isScrollEnabled = false
        labelText.backgroundColor = .systemBackground
        return labelText
    }()
    
    private lazy var closeButton = CustomRoundedButton(image: .Onboarding.closeIcon, target: self, action: #selector(closeButtonPressed), width: 20.0, height: 20.0, color: .clear, toRight: true, textColor: .AppColors.greyColor)
    
    weak var delegate: OnboardingCellDelegate?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureVerticalStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillOnboardingData(onboarding: Onboarding) {
        image.image = onboarding.image
        titleText.text = onboarding.titleText
        labelText.text = onboarding.labelText
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
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.distribution = .equalSpacing
        verticalStack.backgroundColor = .systemBackground
        verticalStack.spacing = UIConstants.verticalStackSpacing
        addSubview(verticalStack)
        
        verticalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.padding).isActive = true
        verticalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -UIConstants.padding).isActive = true
        verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: UIConstants.topPadding).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.padding).isActive = true
    }
    
    @objc func closeButtonPressed(){
        delegate?.closeButtonPressed()
    }
}
