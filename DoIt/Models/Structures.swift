//
//  Structures.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit
import Firebase

class Task {
    let image: UIImage?
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
    
    init(image: UIImage?, title: String, description: String?, deadline: Date?, isDone: Bool, color: UIColor, uid: String = "") {
        self.image = image
        self.title = title
        self.description = description
        self.deadline = deadline
        self.isDone = isDone
        self.uid = ""
        self.color = color
        self.creationTime = Date()
        self.chapterId = 0
    }
}

struct Chapter {
    let title: String
    let color: UIColor
}
