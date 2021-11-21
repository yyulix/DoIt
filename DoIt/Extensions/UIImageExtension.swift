//
//  UIImageExtension.swift
//  DoIt
//
//  Created by Yulia on 26.10.2021.
//

import UIKit

extension UIImage {
    struct AuthIcons {
        static var personIcon: UIImage { UIImage(systemName: "person")! }
        static var envelopeIcon: UIImage { UIImage(systemName: "envelope")! }
        static var lockIcon: UIImage { UIImage(systemName: "lock")! }
    }
    
    struct TaskIcons {
        static var done: UIImage { UIImage(named: "isDone")! }
        static var notDone: UIImage { UIImage(named: "isNotDone")! }
        static var standartImage: UIImage { UIImage(named: "standartImage")! }
    }
}
