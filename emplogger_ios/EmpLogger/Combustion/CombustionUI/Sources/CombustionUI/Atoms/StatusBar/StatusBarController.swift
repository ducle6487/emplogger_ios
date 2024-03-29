//
//  StatusBarController.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

protocol StatusBarUpdater {
    func setNeedsStatusBarAppearanceUpdate()
}

// MARK: - Hosting controller for hosting status bar style
public class StatusBarController<Content: View>: UIHostingController<Content>, StatusBarUpdater {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.statusBarStyle
    }
    
    public override init(rootView: Content) {
        // On init create set our hosting controller
        super.init(rootView: rootView)
        UIApplication.setStatusBarUpdater(self)
    }

    public required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Global status bar storage
extension UIApplication {
    // Store our status bar in our application main for access
    static var statusBarStyle: UIStatusBarStyle = .darkContent
    static var satusBarUpdater: (any StatusBarUpdater)?
    
    static func setStatusBarUpdater(_ updater: any StatusBarUpdater) {
        self.satusBarUpdater = updater
    }
    
    static func setStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
        satusBarUpdater?.setNeedsStatusBarAppearanceUpdate()
    }
}
