//
//  Structures.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit
import Firebase

final class Task {
    let taskId: String
    var image: URL?
    let title: String
    let description: String?
    let deadline: Date?
    var isDone: Bool
    let uid: String
    let color: UIColor
    let chapterId: Int
    let creationTime: Date
    
    var isMyTask: Bool {
        return Auth.auth().currentUser?.uid == uid
    }
    
    init(id: String, dictionary: [String: AnyObject]) {
        taskId = id
        if let profileImageUrlString = dictionary["userPhotoUrl"] as? String {
            if !profileImageUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                image = URL(string: profileImageUrlString)
            } else {
                image = nil
            }
        } else {
            image = nil
        }
        title = dictionary["title"] as? String ?? ""
        if let desciption = dictionary["description"] as? String {
            if !desciption.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.description = desciption
            } else {
                self.description = nil
            }
        } else {
            description = nil
        }
        if let deadlineTimestamp = dictionary["deadline"] as? Double, deadlineTimestamp != 0 {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        } else {
            deadline = nil
        }
        isDone = dictionary["is_done"] as? Bool ?? false
        uid = dictionary["uid"] as? String ?? ""
        if let colorHex = dictionary["color"] as? Int {
            color = UIColor().ColorFromHex(rgbValue: colorHex)
        } else {
            color = .clear
        }
        if let creationTimestamp = dictionary["timestamp"] as? Double {
            creationTime = Date(timeIntervalSince1970: creationTimestamp)
        } else {
            creationTime = Date()
        }
        if let imageUrlString = dictionary["taskImageUrl"] as? String {
            if !imageUrlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self.image = URL(string: imageUrlString)
            }
        }
        chapterId = dictionary["chapter_id"] as? Int ?? 0
    }
}

struct Chapter {
    let title: String
    let color: UIColor
}
