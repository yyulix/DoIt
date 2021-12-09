//
//  CustomUIElementsProfile.swift
//  DoIt
//
//  Created by Шестаков Никита on 03.11.2021.
//

import Foundation
import UIKit

final class InputBox: UIView {
    // MARK: - Properties
    
    struct Constants {
        static let fontSize: CGFloat = 17
        static let padding: CGFloat = 28.0
        static let adjustWidthToTextView: CGFloat = 8
        static let underScopeViewHeight: CGFloat = 1
    }
    
    var textView: UITextView = UITextView()
    var placeholder: String?
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            guard text != "" else { return }
            removePlaceholder()
            textView.text = text
            layoutIfNeeded()
            updateLayout()
        }
    }
    
    
    private var isOversized = false {
        didSet {
            guard textView.contentSize.height != previousHeight else { return }
            guard textView.contentSize.height <= maxHeight else { return }
            textView.isScrollEnabled = isOversized
            textView.sizeToFit()
            textView.layoutIfNeeded()
        }
    }
    
    private var maxHeight: CGFloat = 0
    private var previousHeight: CGFloat = 0
    private var underScopeView: UIView = UIView()
    
    // MARK: - Initializers
    
    init(maxHeight: CGFloat, placeholder: String? = nil) {
        self.maxHeight = maxHeight
        self.placeholder = placeholder
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func removePlaceholder() {
        guard let placeholder = placeholder else { return }
        guard textView.text.isEmpty || textView.text == placeholder else { return }
        textView.text = ""
        textView.textColor = .label
    }
    
    func setPlaceholder() {
        guard textView.text.isEmpty else { return }
        guard let placeholder = placeholder else { return }
        
        textView.text = placeholder
        textView.textColor = .secondaryLabel.withAlphaComponent(0.3)
    }
    
    func updateLayout() {
        isOversized = textView.contentSize.height >= maxHeight
        previousHeight = textView.contentSize.height
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        configureView()
        setPlaceholder()
    }
    
    private func configureView() {
        [textView, underScopeView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding).isActive = true
            $0.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.padding).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        textView.textContainer.lineFragmentPadding = 0
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        textView.scrollsToTop = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: Constants.fontSize)
        textView.layer.zPosition = 1
        
        underScopeView.heightAnchor.constraint(equalToConstant: Constants.underScopeViewHeight).isActive = true
        underScopeView.backgroundColor = .AppColors.accentColor
        underScopeView.layer.zPosition = 2
    }
}
