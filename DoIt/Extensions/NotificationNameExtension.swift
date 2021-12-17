//
//  NotificationCenterExtension.swift
//  DoIt
//
//  Created by Шестаков Никита on 11.12.2021.
//

import Foundation

extension Notification.Name {
    static let openTasksFromProfile = Notification.Name("openTasks.Profile")
    static let openTasksFromFeed = Notification.Name("openTasks.Feed")
    static let personWasFollowedInProfile = Notification.Name("personWasFollowedInProfile")
    static let personWasFollowed = Notification.Name("personWasFollowed")
}
