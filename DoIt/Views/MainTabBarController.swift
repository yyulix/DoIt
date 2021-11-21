//
//  MainTabBarController.swift
//  DoItApp TEMP
//
//  Created by Данил Иванов on 23.10.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.backgroundColor = UIColor.AppColors.accentColor
        tabBar.tintColor = UIColor.white
        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        let tasks = TasksController()
        let feed = FeedController()
        
        viewControllers = [configuredController(image: UIImage(systemName: "square.text.square"), rootViewController: tasks),
                           configuredController(image: UIImage(systemName: "square.grid.2x2"), rootViewController: feed)]
    }
    
    func configuredController(image: UIImage?, rootViewController: UIViewController) -> UIViewController {
        let nav = rootViewController
        nav.tabBarItem.image = image
        return nav
    }
}
