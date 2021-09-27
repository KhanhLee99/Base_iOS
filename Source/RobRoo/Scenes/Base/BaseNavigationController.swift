//
//  BaseNaviVC.swift
//  SmartExpense
//
//  Created by Dương Công Thi on 11/27/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
             self.navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarHidden(true, animated: true)
    }
}

extension BaseNavigationController {
    func push(to vc:UIViewController,_ hideTab: Bool = false,_ flag: Bool = true) {
        vc.hidesBottomBarWhenPushed = hideTab
        pushViewController(vc, animated: flag)
    }
    
    func back(_ flag: Bool = true) {
        popViewController(animated: flag)
    }
    
    func backToRoot(_ flag: Bool = true) {
        popToRootViewController(animated: flag)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
