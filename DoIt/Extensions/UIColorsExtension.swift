//
//  UIColors.swift
//  DoIt
//
//  Created by Y u l i a on 26.10.2021.
//

import UIKit

extension UIColor {
    struct AppColors {
        static let accentColor = UIColor.systemTeal
        static let mainTextColor = UIColor.black
        static let minorTextColor = UIColor.systemGray
        static let taskDeadlineColor = UIColor.black
        static let feedBackgroundColor = UIColor.systemGray5
        static let navigationTextColor = UIColor.white
        static let greyColor = UIColor.init(white: 200 / 255, alpha: 1)
        static let cancelColor = UIColor.systemPink
        static let taskDoneColor = UIColor.green
        static let taskOutdatedColor = UIColor.red
        static let exitColor = UIColor(red: 0.96, green: 0.84, blue: 0.65, alpha: 1)
        static let doneColor = UIColor(red: 0.43, green: 0.75, blue: 0.55, alpha: 1)
        static let purpleColor = UIColor(red: 0.53, green: 0.46, blue: 0.66, alpha: 1.00)
    }

    struct ProfileColors {
        static let headerColor = UIColor(named: "ProfileHeaderColor")!
    }
}
