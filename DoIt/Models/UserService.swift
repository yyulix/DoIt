//
//  UserModel.swift
//  DoIt
//
//  Created by Yulia on 04.12.2021.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference)-> Void)

class UserService {
    
    static let shared = UserService()
        
    func fetchUser(uid: String, completion: @escaping(UserModel)->Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            
            let user = UserModel(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }

    func updateUserPhoto(image: UIImage, completion: @escaping(URL?)-> Void){
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {return}
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let ref = STORAGE_PROFILE_IMAGES.child(NSUUID().uuidString)

            ref.putData(imageData, metadata: nil) { (meta, err) in
                ref.downloadURL { (url, err) in
                    guard let userPhotoUrl = url?.absoluteString else {return}
                    let values = ["userPhotoUrl": userPhotoUrl]
                    REF_USERS.child(uid).updateChildValues(values) { (err, ref) in
                        completion(url)
                    }
                }
            }
        }

    func updateUserData(user: UserModel, completion: @escaping(DatabaseCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let values: [String: Any] = ["username": user.username, "summary": user.summary ?? "", "name": user.name ?? "", "userPhotoUrl": user.image?.absoluteString ?? ""]
        
        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchUsers(completion: @escaping([UserModel])->Void) {
        var users = [UserModel]()
        REF_USERS.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let user = UserModel(uid: uid, dictionary: dictionary)
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

        REF_USER_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.exists())
        }
    }
    
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
