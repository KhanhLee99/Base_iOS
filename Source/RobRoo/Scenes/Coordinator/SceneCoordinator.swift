//
//  SceneCoordinator.swift
//  MVVM
//
//  Created by Michal Ziobro on 04/11/2019.
//  Copyright © 2019 Michal Ziobro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

enum SceneTransitionType {
    case root
    case push
    case modal
    case embed(container: UIView)
}

protocol ISceneCoordinator {
    /// transition to another scene
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable
    
    /// pop scene from navigation stack or dismiss current modal
    @discardableResult
    func pop(animated: Bool) -> Completable
}

extension ISceneCoordinator {
    @discardableResult
    func pop() -> Completable {
        return pop(animated: true)
    }
}

class SceneCoordinator: NSObject, ISceneCoordinator {
    
    var window: UIWindow
    var currentViewController: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        self.currentViewController = window.rootViewController!
    }
}

// MARK: - Helpers
extension SceneCoordinator {
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? BaseNavigationController {
            return navigationController.viewControllers.first!
        } else {
            return viewController
        }
    }
}

extension SceneCoordinator {
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        
        let subject = PublishSubject<Void>()
        
        guard let vc = scene.viewController else {
            return subject.asObservable()
                .take(1)
                .asCompletableIgnoringEvents()
        }
        
        switch type {
        case .root:
            
            currentViewController = SceneCoordinator.actualViewController(for: vc)
            window.rootViewController = vc
            window.makeKeyAndVisible()
            subject.onCompleted()
            
        case .push:
            
            guard let nc = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            
            // set coordinator as the navigation controller's delegate
            // do this prior navigationController.rx.delegate as it
            // takes care of preserving the configured delegate
            nc.delegate = self
            
            // subscription to be notified when push complete
            _ = nc.rx.delegate  .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            
            nc.pushViewController(vc, animated: true)
        case .modal:
            
            currentViewController.present(vc, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: vc)
            
        case .embed(let container):
            
            currentViewController.add(child: vc, container: container)
            currentViewController = vc
            subject.onCompleted()
        }
        
        return subject.asObservable()
            .take(1)
            .asCompletableIgnoringEvents()
    }
}

extension ObservableType {
    func asCompletableIgnoringEvents() -> Completable {
        return self.ignoreElements()
            .asCompletable()
    }
}

extension SceneCoordinator {
    
    @discardableResult
    func pop(animated: Bool) -> Completable {
        
        let subject = PublishSubject<Void>()
        
        if let presenter = currentViewController.presentingViewController {
            
            // dismiss modally presented controller
            presenter.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
                subject.onCompleted()
            }
        } else if let navigationController = currentViewController.navigationController {
            
            // coordinator has been set as delegate of navigation controller
            // during the push transition
            
            // navigate up the stack
            // subscribe to be notified when pop complete
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
        } else if let parent = currentViewController.parent {
            // is child view controller embed in parent view controller
            currentViewController.remove()
            currentViewController = parent
            subject.onCompleted()
        }
        
        return subject.asObserver()
            .take(1)
            .asCompletableIgnoringEvents()
    }
}

// MARK: - Navigation Controller Delegate
extension SceneCoordinator : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        currentViewController = viewController
    }
}

extension SceneCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}


extension UIViewController {
    
    @objc class var identifier : String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    @objc func add(child: UIViewController, container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
