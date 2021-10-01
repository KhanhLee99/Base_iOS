//
//  KHLabel.swift
//  Design
//
//  Created by Apple on 6/21/17.
//

import UIKit

class BaseLabel: UILabel {
    @IBInspectable var title: String = "" {
        didSet {
            self.text = title.localized
        }
    }
}
