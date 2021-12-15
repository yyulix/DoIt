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
    var image: URL?
    let name: String?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    var isFollowed: Bool?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.summary = dictionary["summary"] as? String
        self.name = dictionary["name"] as? String
        if let profileImageUrlString = dictionary["userPhotoUrl"] as? String {
            self.image = URL(string: profileImageUrlString)
        }
    }
    
    // TODO: - FIX IT
    
    init(uid: String, email: String, username: String, summary: String?, imageURL: URL?, name: String?) {
        self.uid = uid
        self.email = email
        self.username = username
        self.summary = summary
        self.image = imageURL
        self.name = name
    }
}
