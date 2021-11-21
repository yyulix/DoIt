//
//  Structures.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

struct Chapter{
    let title: String?
    let color: UIColor?
    let textColor: UIColor?
}

struct Task{
    let image: UIImage?
    let title: String
    let description: String?
    let deadline: Date?
    let isDone: Bool
    let creatorId: Int?
    let color: UIColor?
}
