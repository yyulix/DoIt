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
    
    struct ChapterColors {
        static let shoppingColor = UIColor(red: 1.00, green: 0.45, blue: 0.45, alpha: 1.00)
        static let homeColor = UIColor(red: 1.00, green: 0.67, blue: 0.45, alpha: 1.00)
        static let jobColor = UIColor(red: 1.00, green: 0.78, blue: 0.45, alpha: 1.00)
        static let familyColor = UIColor(red: 1.00, green: 0.86, blue: 0.45, alpha: 1.00)
        
        static let generalColor = UIColor(red: 1.00, green: 0.93, blue: 0.45, alpha: 1.00)
        static let studyColor = UIColor(red: 0.96, green: 0.99, blue: 0.45, alpha: 1.00)
        static let sportColor = UIColor(red: 0.79, green: 0.97, blue: 0.44, alpha: 1.00)
        static let friendsColor = UIColor(red: 0.52, green: 0.92, blue: 0.42, alpha: 1.00)
        
        static let eventsColor = UIColor(red: 0.37, green: 0.83, blue: 0.69, alpha: 1.00)
        static let healthColor = UIColor(red: 0.40, green: 0.64, blue: 0.82, alpha: 1.00)
        static let travelColor = UIColor(red: 0.44, green: 0.49, blue: 0.84, alpha: 1.00)
        static let scienceColor = UIColor(red: 0.55, green: 0.43, blue: 0.84, alpha: 1.00)
        
        static let financeColor = UIColor(red: 0.68, green: 0.40, blue: 0.84, alpha: 1.00)
        static let charityColor = UIColor(red: 0.88, green: 0.40, blue: 0.73, alpha: 1.00)
        static let movingColor = UIColor(red: 0.96, green: 0.43, blue: 0.55, alpha: 1.00)
    }
    
    struct TaskColors {
        static let black: UIColor = .black
        static let white: UIColor = .white
        static let red: UIColor = .red
        static let green: UIColor = .green
        static let blue: UIColor = .blue
        static let yellow: UIColor = .yellow
        static let gray: UIColor = .gray
        static let purple: UIColor = .purple
        static let orange: UIColor = .orange
        static let magenta: UIColor = .magenta
        static let cyan: UIColor = .cyan
        static let brown: UIColor = .brown
    }
}
extension UIColor {
    
    func ColorFromHex(rgbValue: Int) -> UIColor {
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func HexFromColor(color: UIColor) -> Int {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        let hex = (Int(r * 255) << 16) | (Int(g * 255) << 8) | (Int(g * 255))
        return hex
    }
}
