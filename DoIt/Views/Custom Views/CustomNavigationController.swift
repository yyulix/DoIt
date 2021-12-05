//
//  CustomNavigationController.swift
//  DoIt
//
//  Created by Y u l i a on 26.10.2021.
//

import UIKit

final class CustomNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        setupNavigationBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .AppColors.accentColor
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.AppColors.navigationTextColor]
        UINavigationBar.appearance().tintColor = .AppColors.navigationTextColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
