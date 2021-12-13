//
//  TaskCategory.swift
//  DoIt
//
//  Created by Данил Швец on 01.12.2021.
//

import UIKit

struct TaskCategory {
    var chapter: Chapter {
        TaskCategory.chapters[chapterIndex]
    }
    
    static var chaptersCount: Int {
        TaskCategory.chapters.count
    }
    
    private var chapterIndex: Int = 0
    private static let chapters: [Chapter] = [
        Chapter(title: TasksCategory.shopping.rawValue.localized, color: .ChapterColors.shoppingColor),
        Chapter(title: TasksCategory.home.rawValue.localized, color: .ChapterColors.homeColor),
        Chapter(title: TasksCategory.job.rawValue.localized, color: .ChapterColors.jobColor),
        Chapter(title: TasksCategory.family.rawValue.localized, color: .ChapterColors.familyColor),
        
        Chapter(title: TasksCategory.general.rawValue.localized, color: .ChapterColors.generalColor),
        Chapter(title: TasksCategory.study.rawValue.localized, color: .ChapterColors.studyColor),
        Chapter(title: TasksCategory.sport.rawValue.localized, color: .ChapterColors.sportColor),
        Chapter(title: TasksCategory.friends.rawValue.localized, color: .ChapterColors.friendsColor),
        
        Chapter(title: TasksCategory.events.rawValue.localized, color: .ChapterColors.eventsColor),
        Chapter(title: TasksCategory.health.rawValue.localized, color: .ChapterColors.healthColor),
        Chapter(title: TasksCategory.travel.rawValue.localized, color: .ChapterColors.travelColor),
        Chapter(title: TasksCategory.science.rawValue.localized, color: .ChapterColors.scienceColor),
        
        Chapter(title: TasksCategory.finance.rawValue.localized, color: .ChapterColors.financeColor),
        Chapter(title: TasksCategory.moving.rawValue.localized, color: .ChapterColors.movingColor)
    ]
    
    init(index: Int = 0) {
        chapterIndex = min(max(index, 0), TaskCategory.chaptersCount - 1)
    }
}
