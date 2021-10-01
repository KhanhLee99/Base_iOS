//
//  AppDelegate.swift
//  RobRoo
//
//  Created by apple on 5/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast the AppDelegate")
        }
        return delegate
    }()
    
    var window: UIWindow?
    var tabVC: BaseTabbarController?
    var mainNav: BaseNavigationController?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController()
        self.window = window
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppController.me.config()
        setRootTabbar()
        return true
    }
}

extension AppDelegate {
    func setRootTabbar() {
        tabVC = BaseTabbarController()
        mainNav = BaseNavigationController(rootViewController: tabVC!)
        window?.rootViewController = mainNav
        window?.makeKeyAndVisible()
    }
}
