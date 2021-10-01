//
//  NetworkServices.swift
//  OnPlus
//
//

import Foundation
import Alamofire

class NetworkServices {
    static let shared = NetworkServices()
    let reachabilityManager = NetworkReachabilityManager()
    
    static func isNetwork() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func configure() {
        reachabilityManager?.startListening(onUpdatePerforming: { (status) in
            if let isNetworkReachable = self.reachabilityManager?.isReachable,
               isNetworkReachable == true {
            } else {
            }
        })
    }
}
