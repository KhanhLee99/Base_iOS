//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import UIKit
import RxCocoa
import RxSwift

class ___VARIABLE_viewController:identifier___: BaseViewController, Bindable {
    // MARK: - IBOutlet
    
    // MARK: - Properties
    var viewModel: ___VARIABLE_viewModel:identifier___!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bindViewModel() {
        let input = ___VARIABLE_viewModel:identifier___.Input()
        let _ = viewModel.transform(input, disposeBag: disposeBag)
    }
    
    // MARK: - IBAction
}

extension ___VARIABLE_viewController:identifier___ {
    func setupUI() {
    }
}
