//
//  File.swift
//  RobRoo
//
//  Created by apple on 5/12/21.
//

import Foundation
import UIKit

private let appleLanguagesKey = "AppleLanguages"

enum Language: String {
    case english = "en"
    
    static var language: Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = Language(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(
                    preferredLanguage.startIndex,
                    offsetBy: 2
                )
                guard let localization = Language(
                    rawValue: String(preferredLanguage[..<index])
                    ) else {
                        return Language.english
                }
                
                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
        }
    }
}


extension String {
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
    var localizedImage: UIImage? {
        return localizedImage()
            ?? localizedImage(type: ".png")
            ?? localizedImage(type: ".jpg")
            ?? localizedImage(type: ".jpeg")
            ?? UIImage(named: self)
    }
    
    private func localizedImage(type: String = "") -> UIImage? {
        guard let imagePath = Bundle.localizedBundle.path(forResource: self, ofType: type) else {
            return nil
        }
        return UIImage(contentsOfFile: imagePath)
    }
}

extension Bundle {
    static var localizedBundle: Bundle {
        let languageCode = Language.language.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}
