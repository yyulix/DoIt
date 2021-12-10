//
//  Strings.swift
//  DoIt
//
//  Created by Yulia on 28.10.2021.
//

import Foundation

enum AuthStrings: String {
    case username = "auth.username"
    case email = "auth.email"
    case password = "auth.password"
    case retypePassword = "auth.retypePassword"
    case signUp = "auth.signUp"
    case signIn = "auth.signIn"
    case alreadySignedUp = "auth.alreadySignedUp"
    case notSignedUp = "auth.notSignedUp"
    // screen headers
    case headerSignIn = "auth.headerSignIn"
    case headerSignUp = "auth.headerSignUp"
}

enum TaskString: String {
    case title = "task.title"
    case description = "task.description"
    case deadline = "task.deadline"
}

enum FindUsersStrings: String {
    case header = "findUsers.header"
    case followButton = "findUsers.followButton"
    case unfollowButton = "findUsers.unfollowButton"
    case searchPlaceholder = "findUsers.searchPlaceholder"
}

enum ProfileStrings: String {
    case header = "profile.header"
    case followButton = "profile.followButton"
    case unfollowButton = "profile.unfollowButton"
    case titleSummary = "profile.summary"
    case summaryPlaceholder = "profile.summaryPlaceholder"
    case titleStatistics = "profile.statistics"
    case statisticsInProgress = "profile.statisticsInProgress"
    case statisticsExpired = "profile.statisticsExpired"
    case statisticsDone = "profile.statisticsDone"
    case statisticsTotal = "profile.statisticsTotal"
    case titleTasks = "profile.tasks"
    case noTasks = "profile.notasks"
    case titleFollowings = "profile.followings"
    case noFollowings = "profile.nofollowings"
}

enum ProfileEditString: String {
    case header = "profileEdit.header"
    case newPhoto = "profileEdit.newPhoto"
    case namePlaceholder = "profileEdit.namePlaceholder"
    case loginPlaceholder = "profileEdit.loginPlaceholder"
    case summeryPlaceholder = "profileEdit.summaryPlaceholder"
    case nameHint = "profileEdit.nameHint"
    case loginHint = "profileEdit.loginHint"
    case summaryHint = "profileEdit.summaryHint"
}

enum OnboardingStrings: String {
    case backButton = "onboarding.backButton"
    case nextButton = "onboarding.nextButton"
    case exitButton = "onboarding.exitButton"
}

enum TaskScreen: String {
    case taskName = "taskScreen.taskName"
    case countdown = "taskScreen.countdown"
    case deadline = "taskScreen.deadline"
    case noDeadline = "taskScreen.noDeadline"
    case deadlineText = "taskScreen.deadlineText"
    case chapter = "taskScreen.chapter"
    case chapterText = "taskScreen.chapterText"
    case color = "taskScreen.color"
    case colorText = "taskScreen.colorText"
    case description = "taskScreen.description"
    case descriptionText = "taskScreen.descriptionText"
    case deleteButton = "taskScreen.deleteButton"
    case editButton = "taskScreen.editButton"
    case returnButton = "taskScreen.returnButton"
    case saveButton = "taskScreen.saveButton"
    case changePhotoButton = "taskScreen.changePhotoButton"
    
    case blackColor = "taskScreen.blackColor";
    case whiteColor = "taskScreen.whiteColor";
    case redColor = "taskScreen.redColor";
    case greenColor = "taskScreen.greenColor";
    case blueColor = "taskScreen.blueColor";
    case yellowColor = "taskScreen.yellowColor";
    case grayColor = "taskScreen.grayColor";
    case purpleColor = "taskScreen.purpleColor";
    case orangeColor = "taskScreen.orangeColor";
    case magentaColor = "taskScreen.magentaColor";
    case cyanColor = "taskScreen.cyanColor";
    case brownColor = "taskScreen.brownColor";
}

enum TasksCategory: String {
    case shopping = "tasksCategory.shopping"
    case home = "tasksCategory.home"
    case job = "tasksCategory.job"
    case family = "tasksCategory.family"
    case general = "tasksCategory.general"
    case study = "tasksCategory.study"
    case sport = "tasksCategory.sport"
    case friends = "tasksCategory.friends"
    case events = "tasksCategory.events"
    case health = "tasksCategory.health"
    case travel = "tasksCategory.travel"
    case science = "tasksCategory.science"
    case finance = "tasksCategory.finance"
    case charity = "tasksCategory.charity"
    case moving = "tasksCategory.moving"
}

enum TasksStrings: String {
    case header = "tasks.header"
}

enum FeedStrings: String {
    case header = "feed.header"
}

enum TabBarStrings: String {
    case tasks = "tabbar.tasks"
    case feed = "tabbar.feed"
}
