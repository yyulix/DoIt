//
//  UserModel.swift
//  DoIt
//
//  Created by Шестаков Никита on 20.11.2021.
//

import Foundation
import UIKit

struct UserModel {
    let image: UIImage?
    let name: String?
    let login: String
    let summary: String?
    let statistics: UserStatisticsModel
    let isMyScreen: Bool
    let isFollowed: Bool
}
