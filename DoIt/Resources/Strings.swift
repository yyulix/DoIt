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

enum FindFriendsStrings: String {
    case header = "findFriends.header"
    case followButton = "findFriends.followButton"
    case unfollowButton = "findFriends.unfollowButton"
    case searchPlaceholder = "findFriends.searchPlaceholder"
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
    case titleFriends = "profile.friends"
    case noFriends = "profile.nofriends"
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
    case countdown = "taskScreen.countdown"
    case deadline = "taskScreen.deadline"
    case chapter = "taskScreen.chapter"
    case description = "taskScreen.description"
    case descriptionText = "taskScreen.descriptionText"
    case deleteButton = "taskScreen.deleteButton"
    case editButton = "taskScreen.editButton"
    case returnButton = "taskScreen.returnButton"
    case saveButton = "taskScreen.saveButton"
    case changePhotoButton = "taskScreen.changePhotoButton"
}

enum TasksCategory: String {
    case shopping = "taskScreen.shopping"
    case home = "taskScreen.home"
    case job = "taskScreen.job"
    case family = "taskScreen.family"
    case general = "taskScreen.general"
    case study = "taskScreen.study"
    case sport = "taskScreen.sport"
    case friends = "taskScreen.friends"
    case events = "taskScreen.events"
    case health = "taskScreen.health"
    case travel = "taskScreen.travel"
    case science = "taskScreen.science"
    case finance = "taskScreen.finance"
    case charity = "taskScreen.charity"
    case moving = "taskScreen.moving"
}

