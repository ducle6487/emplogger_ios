//
//  StatusBarHost.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

// MARK: - View root wrapper
public struct StatusBarHost<Content: View>: UIViewControllerRepresentable {
    private var content: Content
    
    public init(content: () -> Content) {
        self.content = content()
    }
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        StatusBarController(rootView: content)
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
