//
//  HelperAssembly.swift
//  MVVM
//
//  Created by Michal Ziobro on 09/11/2019.
//  Copyright © 2019 Michal Ziobro. All rights reserved.
//

import Foundation
import Swinject
import UIKit

class HelperAssembly : Assembly {
    func assemble(container: Container) {
        // Coordinator
        container.register(SceneCoordinator.self) { r in
            let window: UIWindow
            window = ((UIApplication.shared.delegate as? AppDelegate)?.window)!
            return SceneCoordinator(window: window)
        }.inObjectScope(.container)
    }
}
