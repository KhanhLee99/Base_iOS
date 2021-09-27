//
//  ViewModelAssembly.swift
//  MVVM
//
//  Created by Michal Ziobro on 09/11/2019.
//  Copyright © 2019 Michal Ziobro. All rights reserved.
//

import Foundation
import Swinject

class ViewModelAssembly : Assembly {
    func assemble(container: Container) {
        container.register(CodingStyleViewModel.self) { r in
            CodingStyleViewModel()
        }
    }
}
