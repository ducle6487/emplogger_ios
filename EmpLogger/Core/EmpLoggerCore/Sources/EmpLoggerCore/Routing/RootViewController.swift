//
//  RootViewController.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import UIKit
import EmpLoggerInjection

extension UIApplication {
    var currentKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }
    
    var rootViewController: UIViewController? {
        currentKeyWindow?.rootViewController
    }
}

extension DependencyMap {
    
    // Retrieve our root view controller and allow us to swap out at run time
    private struct RootViewControllerKey: DependencyKey {
        static var dependency: UIViewController? = UIApplication.shared.rootViewController
    }
    
    public var rootViewController: UIViewController? {
        get { resolve(key: RootViewControllerKey.self) }
        set { register(key: RootViewControllerKey.self, dependency: newValue) }
    }
    
    private struct RootKeyWindowKey: DependencyKey {
        static var dependency: UIWindow? = UIApplication.shared.currentKeyWindow
    }
    
    public var rootKeyWindow: UIWindow? {
        get { resolve(key: RootKeyWindowKey.self) }
        set { register(key: RootKeyWindowKey.self, dependency: newValue) }
    }
}
