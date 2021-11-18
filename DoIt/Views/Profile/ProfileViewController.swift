//
//  ProfileViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 02.11.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    struct Constants {
        static let defaultOffset: CGFloat = 8
        static let headerHeight: CGFloat = 150
        static let backgroundColor: UIColor = .white
    }
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView(headerHeight: Constants.headerHeight)
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.backgroundColor
        
        configureNavigationController()
        
        view.addSubview(profileView)
        constraintsForProfileView()
    }

    private func configureNavigationController() {
        navigationItem.title = NSLocalizedString(FindFriendsString.header.rawValue, comment: "")
    }
    
    private func constraintsForProfileView() {
        profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        profileView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        profileView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ProfileViewController: NavigationControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
