import Foundation

class SwiftEventBus {
    
    struct Static {
        static let instance = SwiftEventBus()
        static let queue = DispatchQueue(label: "com.cesarferreira.SwiftEventBus", attributes: [])
    }
    
    struct NamedObserver {
        let observer: NSObjectProtocol
        let name: String
    }
    
    var cache = [UInt:[NamedObserver]]()
    
    class func post(_ name: NotificationName, sender: Any? = nil) {
        NotificationCenter.default.post(name: name.getName(), object: sender)
    }
    
    class func post(_ name: NotificationName, sender: NSObject?) {
        NotificationCenter.default.post(name: name.getName(), object: sender)
    }
    
    class func post(_ name: NotificationName, sender: Any? = nil, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: name.getName(), object: sender, userInfo: userInfo)
    }
    
    class func postToMainThread(_ name: NotificationName, sender: Any? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name.getName(), object: sender)
        }
    }
    
    class func postToMainThread(_ name: NotificationName, sender: NSObject?) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name.getName(), object: sender)
        }
    }
    
    class func postToMainThread(_ name: NotificationName, sender: Any? = nil, userInfo: [AnyHashable: Any]?) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name.getName(), object: sender, userInfo: userInfo)
        }
    }
    
    @discardableResult
    class func on(_ target: AnyObject, name: NotificationName, sender: Any? = nil, queue: OperationQueue?, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let observer = NotificationCenter.default.addObserver(forName: name.getName(), object: sender, queue: queue, using: handler)
        let namedObserver = NamedObserver(observer: observer, name: name.rawValue)
        
        Static.queue.sync {
            if isRegistered(target, name: name) {
                if let namedObservers = Static.instance.cache[id] {
                    Static.instance.cache[id] = namedObservers + [namedObserver]
                } else {
                    Static.instance.cache[id] = [namedObserver]
                }
            }
        }
        
        return observer
    }
    
    @discardableResult
    class func onMainThread(_ target: AnyObject, name: NotificationName, sender: Any? = nil, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        return SwiftEventBus.on(target, name: name, sender: sender, queue: OperationQueue.main, handler: handler)
    }
    
    @discardableResult
    class func onBackgroundThread(_ target: AnyObject, name: NotificationName, sender: Any? = nil, handler: @escaping ((Notification?) -> Void)) -> NSObjectProtocol {
        return SwiftEventBus.on(target, name: name, sender: sender, queue: OperationQueue(), handler: handler)
    }
    
    open class func unregister(_ target: AnyObject) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default
        
        Static.queue.sync {
            if let namedObservers = Static.instance.cache.removeValue(forKey: id) {
                for namedObserver in namedObservers {
                    center.removeObserver(namedObserver.observer)
                }
            }
        }
    }
    
    class func unregister(_ target: AnyObject, name: NotificationName) {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        let center = NotificationCenter.default
        
        Static.queue.sync {
            if let namedObservers = Static.instance.cache[id] {
                Static.instance.cache[id] = namedObservers.filter({ (namedObserver: NamedObserver) -> Bool in
                    if namedObserver.name == name.rawValue {
                        center.removeObserver(namedObserver.observer)
                        return false
                    } else {
                        return true
                    }
                })
            }
        }
    }
    
    class func isRegistered(_ target: AnyObject, name: NotificationName) -> Bool {
        let id = UInt(bitPattern: ObjectIdentifier(target))
        return ((Static.instance.cache[id]?.filter { $0.name == name.rawValue }) != nil)
    }
}
