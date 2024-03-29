//
//  CombustionWebView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import WebKit
import SwiftUI
import Combine
import EmpLoggerAPI

public struct CombustionWebView: UIViewRepresentable {
    private var request: URLRequest?
    public var coordinator: NavigationCoordinator = NavigationCoordinator()
    
    public init(url: String) {
        guard let webUrl = URL(string: url) else { return }
        self.request = URLRequest(url: webUrl)
    }
    
    public init(request: URLRequest) {
        self.request = request
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        return WKWebView(frame: .zero)
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        /// iOS 16 + Xcode 14.1 produces a runtime error
        /// [Security] This method should not be called on the main thread as it may lead to UI unresponsiveness.
        ///
        /// This is a known issue within Xcode and has been slated for a fix by Apple devs.
        /// This can be tracked here: https://developer.apple.com/forums/thread/714467?answerId=734799022#734799022
        /// An explanation is also provided as to why this is still safe to call, and why it is safe to ignore
        
        if let request {
            webView.load(request)
            
            // Bind our back and forward
            coordinator.backCancellable = coordinator.didPressBack.sink {
                webView.goBack()
            }
            
            coordinator.forwardCancellable = coordinator.didPressForward.sink {
                webView.goForward()
            }
        }
    }
    
    // MARK: Navigation
    public func navigateBack() {
        coordinator.didPressBack.send()
    }
    
    public func navigateForward() {
        coordinator.didPressForward.send()
    }
    
    public class NavigationCoordinator: NSObject, WKNavigationDelegate {
        // Publish back events
        fileprivate var didPressBack = PassthroughSubject<Void, Never>()
        fileprivate var backCancellable: AnyCancellable?
        
        // Publish forward events
        fileprivate var didPressForward = PassthroughSubject<Void, Never>()
        fileprivate var forwardCancellable: AnyCancellable?
        
        // Publish backstack tracking
        public var backstacker = CurrentValueSubject<WKBackForwardList?, Never>(nil)
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            backstacker.send(webView.backForwardList)
        }
    }
}

struct CombustionWebView_Previews: PreviewProvider {
    static var previews: some View {
        CombustionWebView(url: "www.google.com")
    }
}
