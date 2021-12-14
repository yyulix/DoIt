//
//  SignUpViewModel.swift
//  DoIt
//
//  Created by Данил Иванов on 14.12.2021.
//

import Foundation

class SignUpViewModel: NSObject {
    private var authService = AuthService()
    var isSuccesed = false
    
    func singUp(withEmail: String, withUsername: String, withPassword: String) {
    }
}
