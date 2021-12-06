//
//  UserModel.swift
//  DoIt
//
//  Created by Yulia on 04.12.2021.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference)-> Void)

struct UserService {
    
    static let shared = UserService()
        
    func fetchUser(uid: String, completion: @escaping(User)->Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    // TODO: - Update profile
    
    // TODO: - Update profile picture
    
    func updateUserData(user: User, completion: @escaping(DatabaseCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values = ["username": user.username, "summary": user.summary ?? ""]
        
        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchUsers(completion: @escaping([User])->Void) {
        var users = [User]()
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping(DatabaseCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        REF_USER_FOLLOWING.child(currentUid).updateChildValues([uid : 1]) { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUid: 1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping(DatabaseCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        REF_USER_FOLLOWING.child(currentUid).child(uid).removeValue { (err, ref) in
            REF_USER_FOLLOWERS.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
    }

    func isUserFollowed(uid: String, completion: @escaping(Bool)->Void){
        guard let currentUid = Auth.auth().currentUser?.uid else {return}

        REF_USER_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { snapshot in            completion(snapshot.exists())
        }
    }
    
//    func fetchUserFollowers(uid: String, completion: @escaping([User])->Void){
//
//        var users = [User]()
//
//        REF_USER_FOLLOWERS.child(uid).observe(.childAdded) { (snapshot) in
//            let usr = snapshot.key
//            print("!!!", usr)
//            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
//            let user = User(uid: usr, dictionary: dictionary)
//            users.append(user)
//            completion(users)
//        }
//    }
    
    func fetchUserFollowers(uid: String, completion: @escaping([String])->Void) {
        var users_uid = [String]()
        REF_USER_FOLLOWERS.child(uid).observe(.childAdded) { (snapshot) in

            let follower_uid = snapshot.key
            users_uid.append(follower_uid)
            completion(users_uid)
        }
    }
    
    func fetchUserFollowing(uid: String, completion: @escaping([String])->Void) {
        var users_uid = [String]()
        REF_USER_FOLLOWING.child(uid).observe(.childAdded) { (snapshot) in

            let following_uid = snapshot.key
            users_uid.append(following_uid)
            completion(users_uid)
        }
    }
    
}
