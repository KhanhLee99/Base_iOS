import Foundation

public struct UserDefaultsKey {
    
    public static let DeviceId = UserDefaultsKey("TrueID.Device.Id")
    public static let AppLanguage = UserDefaultsKey("AppLanguage")
    
    //TSS Keys
    public static let PremiumPackageA = UserDefaultsKey("PackageA")
    public static let PremiumPackageB = UserDefaultsKey("PackageB")
    public static let PremiumPackageC = UserDefaultsKey("PackageC")
    public static let PremiumPackageTimestamp = UserDefaultsKey("PremiumPackageTimestamp")
    
    //My account key
    public static let serviceNo = UserDefaultsKey("serviceNo")
    
    //User Inbox
    public static let userInboxUnreadCount = UserDefaultsKey("userInboxUnreadCount")
    public static let userInboxUnreadCountNumber = UserDefaultsKey("userInboxUnreadCountNumber")
    
    //Setting
    public static let isSubmitReferral = UserDefaultsKey("isSubmitReferral")
    
    private let key:String
    
    public static func save() {
        UserDefaults.standard.synchronize()
    }
    
    public init(_ key: String) {
        self.key = key
    }
    
    public var value: Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    public var bool: Bool {
        return (UserDefaults.standard.object(forKey: key) as? Bool) ?? false
    }
    
    public var integer: Int? {
        return UserDefaults.standard.object(forKey: key) as? Int
    }
    
    public var double: Double? {
        return UserDefaults.standard.object(forKey: key) as? Double
    }
    
    public var string: String? {
        return UserDefaults.standard.object(forKey: key) as? String
    }
    
    public var stringArray: [String]? {
        return UserDefaults.standard.object(forKey: key) as? [String]
    }
        
    public var date: Date? {
        return UserDefaults.standard.object(forKey: key) as? Date
    }
    
    public var data: Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
    
    public func set(value: Any?, save: Bool = true) {
        UserDefaults.standard.set(value, forKey: key)
        if save {
            setNamedTimeout("saveUserDefaults", delay: 0.2) {
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    public func remove(save: Bool = true) {
        UserDefaults.standard.removeObject(forKey: key)
        if save {
            setNamedTimeout("saveUserDefaults", delay: 0.2) {
                UserDefaults.standard.synchronize()
            }
        }
    }
}
