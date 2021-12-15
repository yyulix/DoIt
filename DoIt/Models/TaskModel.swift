//
//  Structures.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit
import Firebase

class Task {
    let image: URL?
    let title: String
    let description: String?
    let deadline: Date?
    let isDone: Bool
    let uid: String?
    let color: UIColor
    let chapterId: Int
    let creationTime: Date
    
    var isMyTask: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: User, id: String, dictionary: [String: AnyObject]) {
        if let profileImageUrlString = dictionary["userPhotoUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else {return}
            self.image = url
        }
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        if let deadlineTimestamp = dictionary["deadline"] as? Double {
            self.deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        }
        self.isDone = dictionary["is_done"] as? Bool ?? false
        
        // TODO: - FIX IT
        self.uid = ""
        
        self.color = UIColor().ColorFromHex(rgbValue: dictionary["color"] as! Int)
        
        if let creationTimestamp = dictionary["timestamp"] as? Double {
            self.creationTime = Date(timeIntervalSince1970: creationTimestamp)
        }
        
        // NOT DONE
        self.chapterId = dictionary["chapter_id"] as? Int ?? 0
    }
    
    // TODO: - FIX IT
    
//    init(image: UIImage?, title: String, description: String?, deadline: Date?, isDone: Bool, color: UIColor, uid: String = "") {
//        self.image = image
//        self.title = title
//        self.description = description
//        self.deadline = deadline
//        self.isDone = isDone
//        self.uid = ""
//        self.color = color
//        self.creationTime = Date()
//        self.chapterId = 0
//    }
}

struct Chapter {
    let title: String
    let color: UIColor
}
