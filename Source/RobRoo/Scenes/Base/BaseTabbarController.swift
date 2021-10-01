//
//  BaseTabbarController.swift
//  RobRoo
//
//  Created by apple on 01/10/2021.
//

import UIKit

class BaseTabbarController: UITabBarController {
    var tabBarHeight: CGFloat = 0
    var padding: CGFloat = 5
    var paddingTitle: CGFloat = 5
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let window = UIApplication.shared.currentWindow else {return}
        self.tabBar.frame = CGRect(x: tabBar.x, y: tabBar.y-padding, width: tabBar.width, height: tabBarHeight + window.safeAreaInsets.bottom)
    }
}

extension BaseTabbarController {
    // MARK: - Functions
    func setupUI() {
        let appearance = UITabBarItem.appearance()
//        let normal = [NSAttributedString.Key.font: UIFont(name: "Kanit-Regular", size: 12),
//                      NSAttributedString.Key.foregroundColor: UIColor(hexString: "A5A5A5")]
//        let selected = [NSAttributedString.Key.font: UIFont(name: "Kanit-Regular", size: 12),
//                        NSAttributedString.Key.foregroundColor: UIColor(hexString: "00A8A9")]
//        appearance.setTitleTextAttributes(normal as [NSAttributedString.Key : Any], for: .normal)
//        appearance.setTitleTextAttributes(selected as [NSAttributedString.Key : Any], for: .selected)
        
        tabBar.isTranslucent = false
        let home = DIAppContainer.shared.container.resolve(CodingStyleViewController.self)!
        home.tabBarItem = ItemTabbar.home.defaultItem()
        home.tabBarItem.titlePositionAdjustment.vertical = home.tabBarItem.titlePositionAdjustment.vertical - paddingTitle
        home.tabBarItem.badgeValue = "99"
        home.tabBarItem.badgeColor = .blue
        
        let information = DIAppContainer.shared.container.resolve(CodingStyleViewController.self)!
        information.tabBarItem = ItemTabbar.information.defaultItem()
        information.tabBarItem.titlePositionAdjustment.vertical = information.tabBarItem.titlePositionAdjustment.vertical - paddingTitle
        
        let service = DIAppContainer.shared.container.resolve(CodingStyleViewController.self)!
        service.tabBarItem = ItemTabbar.service.defaultItem()
        service.tabBarItem.titlePositionAdjustment.vertical = service.tabBarItem.titlePositionAdjustment.vertical - paddingTitle
        
        let share = DIAppContainer.shared.container.resolve(CodingStyleViewController.self)!
        share.tabBarItem = ItemTabbar.share.defaultItem()
        share.tabBarItem.titlePositionAdjustment.vertical = share.tabBarItem.titlePositionAdjustment.vertical - paddingTitle
        
        let idea = DIAppContainer.shared.container.resolve(CodingStyleViewController.self)!
        idea.tabBarItem = ItemTabbar.idea.defaultItem()
        idea.tabBarItem.titlePositionAdjustment.vertical = idea.tabBarItem.titlePositionAdjustment.vertical - paddingTitle
        
        let viewControllers: [UIViewController] = [
            BaseNavigationController(rootViewController: home),
            BaseNavigationController(rootViewController: information),
            BaseNavigationController(rootViewController: service),
            BaseNavigationController(rootViewController: share),
            BaseNavigationController(rootViewController: idea)]
        
        setViewControllers(viewControllers, animated: true)
        tabBar.barTintColor = UIColor(hexString: "F9F9F9")
        tabBar.backgroundImage = UIImage(named: "tb_home")
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(hexString: "00A8A9")
        tabBarHeight = self.tabBar.frame.height + padding
        
//        UITabBar.appearance().barTintColor = UIColor.clear
//        UITabBar.appearance().backgroundImage = UIImage(named: "tab_bg")
    }
}
