//
//  DeeplinkInteractor.swift
//  Base
//
//  Created by AnhDuc on 06/03/2024.
//

import UIKit
import Foundation
import EmpLoggerCore
import EmpLoggerInjection
import EmpLoggerFoundation

enum DeeplinkError: Error {
    case unableToParse
    case notValid
}

class DeeplinkInteractor: Interactor, DeeplinkInteracting {
    @Inject(\.router) var router
    @Inject(\.deeplinkingConfig) var config: DeeplinkingConfig

    // MARK: Tabless services
    /// Handles the provided deeplink.
    ///
    /// - Parameter deeplink: The deeplink to be handled.
    func deeplink(to deeplink: Deeplink) {
        switch deeplink.type {
        case .tab(let tab):
            // Navigate to our tab and handle deeplink
            router.navigate(to: tab)
            tab.deeplinkHandler?.handle(deeplink: deeplink)
        case .external(let url): UIApplication.shared.open(url)
        }
    }

    /// Handles the provided deeplink string.
    ///
    /// - Parameter string: The deeplink string to be handled.
    func deeplink(to string: String) {
        guard let resolved = try? resolveDeeplink(from: string) else { return }
        deeplink(to: resolved)
    }

    /// Resolves the provided deeplink string into a `Deeplink` object.
    ///
    /// - Parameter string: The deeplink string to be resolved.
    /// - Returns: The resolved `Deeplink` object.
    /// - Throws: An error of type `DeeplinkError` if the deeplink string cannot be resolved.
    func resolveDeeplink(from string: String) throws -> Deeplink {
        guard let url = URL(string: string) else { throw DeeplinkError.unableToParse }
        let urlComponents = url.host.map { [$0] + url.pathComponents } ?? url.pathComponents

        // Determine if URL origin is the App portal - for deeplinking from universal link
        let isUrlAppPortal = url.absoluteString.hasPrefix(config.appPortalUrl)
        guard !isUrlAppPortal else { return try handleAppPortalDeeplink(url: url) }

        // Determine if URL is an internal link
        guard url.scheme != "ampol" else {
            return try handleInternalDeeplink(urlComponents: urlComponents)
        }

        // If more specific link type isn't found above, treat as external link
        return Deeplink(type: .external(url))
    }
}

// MARK: - Internal deeplinking
extension DeeplinkInteractor {
    /// Resolves a set of deeplink components into an internal deeplink.
    ///
    /// - Parameter String[]: Separated path components of the path to be resolved
    /// - Returns: The resolved `Deeplink` object or `nil` if none were resolved
    func handleInternalDeeplink(urlComponents: [String]) throws -> Deeplink {
        // Filter our components for non-textual url parts
        let components =
            urlComponents
            .filter { $0 != "/" }
            .map { $0.removingPercentEncoding ?? "" }

        // Only resolve our deeplink if it has a tab to execute on
        guard !components.isEmpty else { throw DeeplinkError.notValid }
        guard let tab = Tabs.init(rawValue: components.first!.lowercased()) else {
            throw DeeplinkError.notValid
        }

        // Resolve any actions and querys
        var action: DeeplinkAction?
        if let actionString = components.at(1) {
            action = DeeplinkAction(rawValue: actionString.lowercased())
        }
        let query = components.at(2)

        return Deeplink(type: .tab(tab.tab), action: action, query: query)
    }
}

// MARK: - App Portal originated deeplinking
extension DeeplinkInteractor {
    /// Resolves a set of deeplink components (beginning with the App Portal url) into an internal deeplink
    ///
    /// - Parameter URL: URL object for semi-manual parsing
    /// - Returns: The resolved `Deeplink` `object` or `nil` if none were resolved
    func handleAppPortalDeeplink(url: URL) throws -> Deeplink {
        let urlComponents = url.host.map { [$0] + url.pathComponents } ?? url.pathComponents

        // Filter the App Portal base url
        let components =
            urlComponents
            .dropFirst()  // drops the base url
            .filter { $0 != "/" }
            .map { $0.removingPercentEncoding ?? "" }

        // Only resolve our deeplink if it has a tab to execute on
        guard !components.isEmpty else { throw DeeplinkError.notValid }
        guard let tab = Tabs.init(rawValue: components.at(0)!.lowercased()) else {
            throw DeeplinkError.notValid
        }

        // Resolve any actions and querys
        var action: DeeplinkAction?
        if let actionString = components.at(1) {
            action = DeeplinkAction(rawValue: actionString.lowercased())
        }

        let queries: [URLQueryItem]? = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems

        return Deeplink(type: .tab(tab.tab), action: action, queries: queries)
    }
}
