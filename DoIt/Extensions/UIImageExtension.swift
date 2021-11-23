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
    
    struct ProfileEditIcons {
        static var doneIcon: UIImage { UIImage(systemName: "checkmark")! }
    }
    
    struct ProfileIcons {
        static var gearIcon: UIImage { UIImage(systemName: "gear")! }
    }
    
    struct SearchFriendsIcons {
        static var searchIcon: UIImage { UIImage(systemName: "magnifyingglass")! }
    }
}
