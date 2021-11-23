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
    let tasks: [ProfileTaskModel]?
    let friends: [ProfileFriendsModel]?
    let isMyScreen: Bool
    let isFollowed: Bool
}
