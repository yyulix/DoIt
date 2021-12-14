//
//  UserModel.swift
//  DoIt
//
//  Created by Yulia on 05.12.2021.
//
//

import Firebase

class UserModel {
    
    let uid: String
    let email: String
    var username: String
    var summary: String?
    let image: UIImage?
    let name: String?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.summary = dictionary["summary"] as? String
        self.image = nil
        self.name = nil
    }
    
    init(username: String) {
        self.uid = ""
        self.email = ""
        self.username = username
        self.summary = nil
        self.image = nil
        self.name = nil
    }
}
