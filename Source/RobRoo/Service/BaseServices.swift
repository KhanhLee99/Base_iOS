//
//  BaseServices.swift
//  OnPlus
//
//

import Foundation

enum BaseServiceType {
    case dev, live
}

class BaseServices {
    var baseUrl: String
  
    static let shared = BaseServices()
    
    private init() {
        baseUrl = "http://maxline.hu:8080/onapi/"
    }
    
    func config(_ type: BaseServiceType) {
        switch type {
        case .dev:
            baseUrl = "http://maxline.hu:8080/onapi/"
            break
        case .live:
            baseUrl = "http://maxline.hu:8080/onapi/"
            break
        }
    }
}

