//
//  TaskCategory.swift
//  DoIt
//
//  Created by Данил Швец on 01.12.2021.
//

import UIKit

struct TaskCategory {
    let chapter: String?
    
    private var index: Int
    
    init(index: Int){
        self.index = index
        switch index {
        case 0:
            self.chapter = TasksCategory.shopping.rawValue.localized
        case 1:
            self.chapter = TasksCategory.home.rawValue.localized
        case 2:
            self.chapter = TasksCategory.job.rawValue.localized
        case 3:
            self.chapter = TasksCategory.family.rawValue.localized
        case 4:
            self.chapter = TasksCategory.general.rawValue.localized
        case 5:
            self.chapter = TasksCategory.study.rawValue.localized
        case 6:
            self.chapter = TasksCategory.sport.rawValue.localized
        case 7:
            self.chapter = TasksCategory.friends.rawValue.localized
        case 8:
            self.chapter = TasksCategory.events.rawValue.localized
        case 9:
            self.chapter = TasksCategory.health.rawValue.localized
        case 10:
            self.chapter = TasksCategory.travel.rawValue.localized
        case 11:
            self.chapter = TasksCategory.science.rawValue.localized
        case 12:
            self.chapter = TasksCategory.finance.rawValue.localized
        case 13:
            self.chapter = TasksCategory.charity.rawValue.localized
        case 14:
            self.chapter = TasksCategory.moving.rawValue.localized
        default:
            self.chapter = "Default"
        }
    }
}
