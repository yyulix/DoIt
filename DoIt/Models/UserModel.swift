//
//  UserModel.swift
//  DoIt
//
//  Created by Yulia on 05.12.2021.
//
//

import Firebase

struct User {
    
    let uid: String
    let email: String
    var username: String
    var summary: String?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid:String, dictionary:[String:AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.summary = dictionary["summary"] as? String ?? ""
    }
}
