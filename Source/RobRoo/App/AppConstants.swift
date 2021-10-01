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

enum ItemTabbar: Int {
    case home = 0
    case information
    case service
    case share
    case idea
    
    func title() -> String {
        switch self {
        case .home:
            return "home.tab".localized()
        case .information:
            return "ข้อมูล".localized()
        case .service:
            return "งานบริการ".localized()
        case .share:
            return "แบ่งปัน".localized()
        default:
            return "ความรู้".localized()
        }
    }
    
    func icon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "tb_home")
        case .information:
            return UIImage(named: "tb_information")
        case .service:
            return UIImage(named: "tb_service")
        case .share:
            return UIImage(named: "tb_share")
        default:
            return UIImage(named: "tb_idea")
        }
    }
    
    func defaultItem() -> UITabBarItem {
        return UITabBarItem(title: self.title(), image: self.icon(), selectedImage: self.icon())
    }
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
