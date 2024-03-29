//
//  DeeplinkHandler.swift
//  
//
//  Created by AnhDuc on 04/03/2024.
//

/// The `DeeplinkHandler` protocol defines the contract for an interactor
/// that can handle deeplinks within the application. It should be conformed
/// to by top-level interactors for each tab in the application.
public protocol DeeplinkHandler {
    
    /// Handles the provided deeplink.
    ///
    /// - Parameter deeplink: The deeplink to be handled.
    func handle(deeplink: Deeplink)
}
