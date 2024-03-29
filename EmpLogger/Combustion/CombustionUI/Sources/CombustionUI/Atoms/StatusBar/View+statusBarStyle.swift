//
//  File.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

extension View {
    /// Sets the status bar style for this view
    ///
    /// Sets the status bar that should be active whilst this view is the topmost visible view.
    /// Saves the last status bar style and will reapply it on removal of the view from the view hierarchy.
    public func statusBarStyle(_ style: UIStatusBarStyle) -> some View {
        return self
            .onAppear {
                UIApplication.setStatusBarStyle(style)
            }
    }
}
