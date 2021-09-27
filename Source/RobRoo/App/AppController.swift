//
//  AppController.swift
//  Dibs
//
//  Created by apple on 1/29/21.
//

import UIKit
import IQKeyboardManagerSwift

class AppController: NSObject {
    static let me = AppController()
    static let coor = DIAppContainer.shared.container.resolve(SceneCoordinator.self)!
    static let del = UIApplication.shared.delegate as! AppDelegate
}

extension AppController {
    func config() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        Language.language = .english
    }
}
