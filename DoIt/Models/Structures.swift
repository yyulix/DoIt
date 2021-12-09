//
//  Structures.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

struct Task {
    let image: UIImage?
    let title: String
    let description: String?
    let deadline: Date?
    let isDone: Bool
    let creatorId: String
    let color: UIColor
    let chapterId: Int
    let creationTime: Date
    let isMyTask: Bool
}

struct Chapter {
    let title: String
    let color: UIColor
}
