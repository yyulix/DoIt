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
        static var defaultImage: UIImage { UIImage(named: "standartImage")! }
    }
        
    struct ProfileEditIcons {
        static var doneIcon: UIImage { UIImage(systemName: "checkmark")! }
    }
    
    struct ProfileIcons {
        static var gearIcon: UIImage { UIImage(systemName: "gear")! }
    }
    
    struct SearchFriendsIcons {
        static var personPlaceholderIcon: UIImage { UIImage(named: "imagePlaceHolder")! }
        static var searchIcon: UIImage { UIImage(systemName: "magnifyingglass")! }
    }
}
