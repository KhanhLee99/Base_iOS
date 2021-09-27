//
//  BaseViewController.swift
//  NewApp
//
//  Created by apple on 5/11/21.
//

import UIKit
import RxSwift
import Then

class BaseViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController {
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popTopRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
