//
//  ProfileModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 20.11.2021.
//

import Foundation
import UIKit

struct ProfileModel {
    let image: UIImage?
    let name: String?
    let login: String
    let summary: String?
    let statistics: ProfileStatisticsModel
    let tasks: [TaskModel]?
    let friends: [SearchFriendsModel]?
    let isMyScreen: Bool
    let isFollowed: Bool
}
