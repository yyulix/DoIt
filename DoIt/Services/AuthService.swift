//
//  AuthService.swift
//  DoIt
//
//  Created by Yulia on 30.10.2021.
//

import FirebaseAuth
import FirebaseDatabase

struct AuthService {

    static let shared = AuthService()

    func signIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                Logger.log("DEBUG: Error is \(error.localizedDescription)")
                return
            }
        }
    }

    func signUp(email : String, password : String, username : String, completion: @escaping(Error?, DatabaseReference) -> Void) {

        let email = email
        let password = password
        let username = username

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                Logger.log("DEBUG: Error is \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else { return }

            let values = ["email": email,
                          "username": username]
            let usersReferense = Database.database().reference().child("users").child(uid)
            usersReferense.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
    }
}
