//
//  ViewControllerAssembly.swift
//  MVVM
//
//  Created by Michal Ziobro on 09/11/2019.
//  Copyright © 2019 Michal Ziobro. All rights reserved.
//

import Foundation
import Swinject

class ViewControllerAssembly : Assembly {
    func assemble(container: Container) {
        container.register(CodingStyleViewController.self) { r in
            let vc = CodingStyleViewController()
            vc.bindViewModel(to: r.resolve(CodingStyleViewModel.self)!)
            return vc
        }
    }
}
