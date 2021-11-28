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
        static let navigationTextColor = UIColor.white
        static let grey = UIColor.init(white: 200 / 255, alpha: 1)
        static let cancelColor = UIColor.systemPink
        static let exitColor = UIColor(red: 0.96, green: 0.84, blue: 0.65, alpha: 1)
    }

    struct ProfileColors {
        static let headerColor = UIColor(named: "ProfileHeaderColor")!
    }
}
