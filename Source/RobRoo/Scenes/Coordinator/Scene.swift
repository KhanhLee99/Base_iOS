//
//  File.swift
//  MVVM
//
//  Created by Michal Ziobro on 04/11/2019.
//  Copyright © 2019 Michal Ziobro. All rights reserved.
//

import UIKit

enum Scene {
    case codingStyle
}

extension Scene {
    var viewController : BaseViewController? {
        switch self {
        case .codingStyle:
            return DIAppContainer.shared.container.resolve(CodingStyleViewController.self)!
        }
    }
}
