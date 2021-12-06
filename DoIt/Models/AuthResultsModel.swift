//
//  AuthModel.swift
//  DoIt
//
//  Created by Y u l i a on 04.12.2021.
//

import Foundation
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let username: String
}

enum AuthError {
    case invalidEmail
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("email_is_not_valid", comment: "")
        case .unknownError:
            return NSLocalizedString("server_error", comment: "")
        case .serverError:
            return NSLocalizedString("server_error", comment: "")

        }
    }
}

enum AuthResult {
    case success
    case failure(Error)
}
