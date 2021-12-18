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
    var summary: String? = nil
    var image: URL?
    var name: String? = nil
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    var isFollowed: Bool?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        if let summary = dictionary["summary"] as? String {
            if !summary.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.summary = summary
            }
        }
        if let name = dictionary["name"] as? String {
            if !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.name = name
            }
        }
        if let profileImageUrlString = dictionary["userPhotoUrl"] as? String {
            if !profileImageUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.image = URL(string: profileImageUrlString)
            }
        }
    }
}
