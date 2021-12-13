//
//  KeyboardManager.swift
//  DoIt
//
//  Created by Шестаков Никита on 07.12.2021.
//

import Foundation
import UIKit

class KeyboardManager {
    struct Constants {
        static let keyboardOffset = 30.0
    }
    
    static let shared = KeyboardManager()
    
    private var keyboardHeight = 0.0
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = (sender as NSNotification).userInfo else {
            return
        }
        guard let keyboardHeight = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height else {
            return
        }
        self.keyboardHeight = keyboardHeight
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sender.view?.endEditing(true)
    }

    func scrollViewToLabel(_ textField: UIView, view: UIView, scrollView: UIScrollView, coordinatesCompareWith contentView: UIView? = nil, animated: Bool = true) {
        view.layoutIfNeeded()
        let bottomOfTextField = textField.convert(textField.bounds, to: contentView ?? view).maxY
        let topOfKeyboard = view.frame.height - keyboardHeight
        if bottomOfTextField > topOfKeyboard {
            scrollView.setContentOffset(.init(x: 0, y: abs(topOfKeyboard - bottomOfTextField) + Constants.keyboardOffset), animated: animated)
        }
        view.layoutIfNeeded()
    }

    func scrollViewToDefault(scrollView: UIScrollView) {
        scrollView.setContentOffset(.zero, animated: true)
    }
}
