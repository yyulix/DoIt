//
//  AuthViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 15.12.2021.
//

import Foundation

final class AuthViewModel {
    private let authService = AuthService.shared
    
    var authResultModel: Observable<AuthResult> = Observable()
    
    func signUp(email: String?, username: String?, password: String?, complitionError: (String) -> ()) {
        guard let username = username, !username.isEmpty else {
            complitionError(ErrorStrings.emtyLogin.rawValue.localized)
            return
        }
        guard let email = email, isValidEmail(email: email) else {
            complitionError(ErrorStrings.email.rawValue.localized)
            return
        }
        guard let password = password, password.count >= 6 else {
            complitionError(ErrorStrings.password.rawValue.localized)
            return
        }
        self.authService.signUp(email: email, username: username, password: password) { [weak self] authResult in
            self?.authResultModel.value = authResult
        }
    }
    
    func signIn(email: String?, password: String?, complitionError: (String) -> ()) {
        guard let email = email, isValidEmail(email: email) else {
            complitionError(ErrorStrings.email.rawValue.localized)
            return
        }
        guard let password = password, password.count >= 6 else {
            complitionError(ErrorStrings.password.rawValue.localized)
            return
        }
        self.authService.signIn(email: email, password: password) { [weak self] authResult in
            self?.authResultModel.value = authResult
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
