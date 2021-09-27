//
//  AppConstants.swift
//  RobRoo
//
//  Created by apple on 27/09/2021.
//

import Foundation
import UIKit

class Key {
    
}

enum NotificationName: String {
    case updatedLoginUser
    
    func getName() -> Notification.Name {
        return Notification.Name(rawValue: self.rawValue)
    }
}

enum PlaceholderName: String {
    case profile_no_image_circle
    
}

enum AppColor: String {
    case black20
    
    func toColor() -> UIColor {
        return UIColor(named: self.rawValue) ?? .black
    }
}

enum AppFont: String {
    case PoppinsBold = "Poppins-Bold"
    
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
