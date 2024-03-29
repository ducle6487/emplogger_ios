//
//  Tab.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import SwiftUI
import Foundation

public struct Tab: Identifiable {
    public let id: String
    public let icon: Image
    public let selectedIcon: Image
    public var name: String
    public var event: String
    public var destination: RouteableView
    public var deeplinkHandler: (any DeeplinkHandler)?
    
    public init(
        id: String,
        icon: Image,
        selectedIcon: Image,
        name: String,
        event: String,
        destination: some View,
        deeplinkHandler: (any DeeplinkHandler)? = nil
    ) {
        self.id = id
        self.icon = icon
        self.selectedIcon = selectedIcon
        self.name = name
        self.event = event
        self.destination = RouteableView(destination)
        self.deeplinkHandler = deeplinkHandler
    }
}
