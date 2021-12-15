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
    
    func signUp(email: String?, username: String?, password: String?) {
        self.authService.signUp(email: email, username: username, password: password) { [weak self] authResult in
            self?.authResultModel.value = authResult
        }
    }
    
    func signIn(email: String?, password: String?) {
        self.authService.signIn(email: email, password: password) { authResult in
            switch authResult {
            case .success:
                print("Auth success")
            case .failure(let error):
                print("Auth was failured: ", error.localizedDescription)
            }
        }
    }
}
