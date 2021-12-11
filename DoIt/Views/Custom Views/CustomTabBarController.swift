//
//  ProfileEditViewController.swift
//  DoIt
//
//  Created by Шестаков Никита on 10.12.2021.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let tabBar: CustomTabBar = {
            let tabBar = CustomTabBar()
            tabBar.centerButtonColor = .AppColors.purpleColor
            tabBar.buttonImage = .TabBarIcons.addTaskIcon
            tabBar.tintColor = .AppColors.navigationTextColor
            tabBar.centerButtonActionHandler = { [weak self] in
                let newTaskViewController = TaskEditViewController()
                self?.present(newTaskViewController, animated: true)
            }
            return tabBar
        }()
        setValue(tabBar, forKey: "tabBar")
        configureViewControllers()
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        let userModel = UserModel(image: nil, name: nil, login: "", summary: nil, statistics: UserStatisticsModel(inProgress: "0", outdated: "0", done: "0", total: "0"), isMyScreen: true, isFollowed: false)
        
        let tasks = TasksController()
        tasks.userModel = userModel
        tasks.tabBarItem = UITabBarItem(title: TabBarStrings.tasks.rawValue.localized, image: .TabBarIcons.tasksIcon, selectedImage: nil)
        
        let feed = FeedController()
        feed.userModel = userModel
        feed.tabBarItem = UITabBarItem(title: TabBarStrings.feed.rawValue.localized, image: .TabBarIcons.feedIcon, selectedImage: nil)
        
        let controllers = [ CustomNavigationController(rootViewController: tasks), CustomNavigationController(rootViewController: feed) ]
        
        viewControllers = controllers
        selectedViewController = controllers[0]
    }
}

final class CustomTabBar: UITabBar {
    var centerButtonColor: UIColor?
    var centerButtonHeight: CGFloat = 50.0
    var padding: CGFloat = 5.0
    var buttonImage: UIImage?
    
    var tabbarColor: UIColor = .AppColors.accentColor
    var unselectedItemColor: UIColor = .AppColors.greyColor
    
    var centerButtonActionHandler: (() -> ())?
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
        
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = tabbarColor.cgColor
        shapeLayer.lineWidth = 0
        
        self.shapeLayer == nil ? layer.insertSublayer(shapeLayer, at: 0) : layer.replaceSublayer(self.shapeLayer!, with: shapeLayer)
        
        self.shapeLayer = shapeLayer
        unselectedItemTintColor = unselectedItemColor
        setupMiddleButton()
    }
    
    private func createPath() -> CGPath {
        let f = CGFloat(centerButtonHeight / 2.0) + padding
        let h = frame.height
        let w = frame.width
        let halfW = frame.width / 2.0
        let r = CGFloat(18)
        let path = UIBezierPath()
        path.move(to: .zero)
        
        path.addLine(to: CGPoint(x: halfW - f - (r / 2.0), y: 0))
        
        path.addQuadCurve(to: CGPoint(x: halfW - f, y: (r / 2.0)), controlPoint: CGPoint(x: halfW - f, y: 0))
        
        path.addArc(withCenter: CGPoint(x: halfW, y: (r / 2.0)), radius: f, startAngle: .pi, endAngle: 0, clockwise: false)
        
        path.addQuadCurve(to: CGPoint(x: halfW + f + (r / 2.0), y: 0), controlPoint: CGPoint(x: halfW + f, y: 0))
        
        path.addLine(to: CGPoint(x: w, y: 0))
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0.0, y: h))
        
        return path.cgPath
    }
    
    private func setupMiddleButton() {
        let centerButton = UIButton(frame: CGRect(x: (self.bounds.width / 2) - (centerButtonHeight / 2), y: -20, width: centerButtonHeight, height: centerButtonHeight))
        
        centerButton.layer.cornerRadius = centerButton.frame.size.width / 2.0
        centerButton.setImage(buttonImage, for: .normal)
        centerButton.backgroundColor = centerButtonColor
        centerButton.tintColor = .AppColors.navigationTextColor

        addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(centerButtonAction), for: .touchUpInside)
    }
    
     @objc private func centerButtonAction(sender: UIButton) {
        centerButtonActionHandler?()
     }
}
