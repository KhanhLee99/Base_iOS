//
//  CodingStyleViewModel.swift
//  NewApp
//
//  Created by apple on 5/11/21.
//
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct CodingStyleViewModel {
    
}

extension CodingStyleViewModel: ViewModel {
    struct Input {
    }
    
    struct Output {
        @Property var demoData: [String] = ["Hello", "Haha", "aaa", "bbbb"]
    }
    
    func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        return output
    }
}
