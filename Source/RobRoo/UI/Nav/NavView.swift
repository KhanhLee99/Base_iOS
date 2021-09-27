//
//  NavView.swift
//  RobRoo
//
//  Created by apple on 27/09/2021.
//
//

import UIKit
import Reusable

class NavView: UIView, NibOwnerLoadable {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        loadNibContent()
    }
}
