//
//  BaseTableView.swift
//  RobRoo
//
//  Created by Hoa Pham on 6/18/21.
//

import UIKit

class BaseTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}
