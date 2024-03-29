//
//  SafariWebView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import SafariServices
import EmpLoggerInjection

public struct SafariWebView: UIViewControllerRepresentable {
    let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
