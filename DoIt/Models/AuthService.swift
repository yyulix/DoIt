//
//  AuthService.swift
//  DoIt
//
//  Created by Y u l i a on 06.12.2021.
//

import Firebase

class AuthService {

    static let shared = AuthService()

    func signIn(email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            let uid = result.user.uid
            
            UserDefaults.standard.set(uid, forKey: "current_user")

            completion(.success)
        }
    }

    public func signUp(email: String?, username: String?, password: String?, completion: @escaping (AuthResult) -> Void) {

        guard let email = email, let username = username, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }

            let uid = result.user.uid
            
            UserDefaults.standard.set(uid, forKey: "current_user")
            
            let values = ["email": email,
                          "username": username]
            let usersReferense = Database.database().reference().child("users").child(uid)
            usersReferense.child(uid).updateChildValues(values)
            completion(.success)
        }
    }
}
