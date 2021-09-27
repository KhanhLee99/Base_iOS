//
//  AppContainer.swift
//  MVVM
//
//  Created by Michal Ziobro on 03/11/2019.
//  Copyright © 2019 Michal Ziobro. All rights reserved.
//

import Foundation

import Swinject
import SwinjectAutoregistration

public class DIAppContainer {
    
    static var shared = DIAppContainer()
    
    let container = Container()
    let assembler: Assembler
    
    private init() {
        
        // the assembler gathers all the dependencies in one place
        assembler = Assembler([
            HelperAssembly(),
            ViewModelAssembly(),
            ViewControllerAssembly()
        ], container: container)
    }
}
