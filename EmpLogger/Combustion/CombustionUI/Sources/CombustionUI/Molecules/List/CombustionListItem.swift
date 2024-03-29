//
//  CombustionListItem.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

public struct CombustionListItem {
    public typealias LazyAnyView = () -> AnyView
    public typealias ListAction = () -> Void
    var id: UUID
    var destination: LazyAnyView?
    
    // Property for programatically navigating to a navlink
    var navigate: Bool = false
    var action: ListAction?
    var actionShowChevron: Bool = false
    var content: LazyAnyView
    
    /// Init for list item that navigates
    public init(
        id: UUID = UUID(),
        _ destination: some View,
        navigate: Bool = false,
        @ViewBuilder content: @escaping () -> some View
    ) {
        self.id = id
        self.destination = { AnyView(destination) }
        self.content = { AnyView(content()) }
    }
    
    /// Init for list item that does not navigate
    public init(id: UUID = UUID(), @ViewBuilder content: @escaping () -> some View) {
        self.id = id
        self.content = { AnyView(content()) }
    }
    
    /// Init for list item that performs an action
    public init(
        id: UUID = UUID(),
        action: ListAction? = nil,
        chevron: Bool = false,
        @ViewBuilder content: @escaping () -> some View
    ) {
        self.id = id
        self.action = action
        self.actionShowChevron = chevron
        self.content = { AnyView(content()) }
    }
    
    /// Init for list item that performs an action with autoclosure
    public init(
        id: UUID = UUID(),
        action: @escaping @autoclosure ListAction,
        chevron: Bool = false,
        @ViewBuilder content: @escaping () -> some View
    ) {
        self.init(id: id, action: { action() }, chevron: chevron, content: content)
    }
}
