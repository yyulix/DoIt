//
//  Structures.swift
//  DoIt
//
//  Created by Данил Иванов on 07.11.2021.
//

import UIKit

struct ChapterStruct{
    let title: String?
    let color: UIColor?
    let textColor: UIColor?
}

struct TaskStruct{
    let image: UIImage?
    let title: String?
    let description: String?
    let deadline: Date?
    let isDone: Bool
    let creator: Int?
    let color: UIColor?
}
