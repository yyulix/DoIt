//
//  UIImageExtension.swift
//  DoIt
//
//  Created by Yulia on 26.10.2021.
//

import UIKit
import Firebase

extension UIImage {
    struct AuthIcons {
        static var personIcon: UIImage { UIImage(systemName: "person")! }
        static var envelopeIcon: UIImage { UIImage(systemName: "envelope")! }
        static var lockIcon: UIImage { UIImage(systemName: "lock")! }
    }
    
    struct Onboarding {
        static var closeIcon: UIImage { UIImage(systemName: "xmark")! }
    }
    
    struct TaskIcons {
        static var done: UIImage { UIImage(named: "isDone")! }
        static var notDone: UIImage { UIImage(named: "isNotDone")! }
        static var defaultImage: UIImage { UIImage(named: "standartImage")! }
        static var doneIcon: UIImage { UIImage(systemName: "checkmark.circle")! }
        static var outdatedIcon: UIImage { UIImage(systemName: "xmark.square")! }
        static var trashIcon: UIImage { UIImage(systemName: "trash.circle")! }
        static var checkMarkIcon: UIImage { UIImage(systemName: "checkmark")! }
        static var editIcon: UIImage { UIImage(systemName: "square.and.pencil")! }
    }
        
    struct ProfileEditIcons {
        static var doneIcon: UIImage { UIImage(systemName: "checkmark")! }
    }
    
    struct ProfileIcons {
        static var gearIcon: UIImage { UIImage(systemName: "gear")! }
        static var allTasksIcon: UIImage { UIImage(systemName: "chevron.right")! }
    }
    
    struct SearchFriendsIcons {
        static var searchIcon: UIImage { UIImage(systemName: "magnifyingglass")! }
    }
    
    struct TabBarIcons {
        static var addTaskIcon: UIImage { UIImage(systemName: "plus")! }
        static var tasksIcon: UIImage { UIImage(systemName: "square.text.square")! }
        static var feedIcon: UIImage { UIImage(systemName: "square.grid.2x2")! }
    }
}
