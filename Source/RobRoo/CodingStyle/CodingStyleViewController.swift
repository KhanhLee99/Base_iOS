//
//  CodingStyleViewController.swift
//  NewApp
//
//  Created by apple on 5/11/21.
//
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SwifterSwift

class CodingStyleViewController: BaseViewController, Bindable {
    // MARK: - IBOutlet
    @IBOutlet weak var tbMain: UITableView!
    
    // MARK: - Properties
    var viewModel: CodingStyleViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bindViewModel() {
        let input = CodingStyleViewModel.Input()
        let output = viewModel.transform(input, disposeBag: disposeBag)
        output.$demoData
            .asDriver()
            .drive(tbMain.rx.items) { tableView, index, model in
                let cell = tableView.dequeueReusableCell(withClass: DemoCell.self)
                return cell.then {
                    $0.selectionStyle = .none
                    $0.lbTitle.text = model
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - IBAction
    @IBAction func actionDemo(_ sender: Any) {
        print("Hello")
    }
}

extension CodingStyleViewController {
    func setupUI() {
        tbMain.do { // Then github => key search
            $0.register(DemoCell.self)
            $0.separatorStyle = .none
            $0.rowHeight = 50
            $0.alwaysBounceVertical = false
        }
    }
}
