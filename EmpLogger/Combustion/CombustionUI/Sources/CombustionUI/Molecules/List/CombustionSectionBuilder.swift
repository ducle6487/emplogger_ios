//
//  CombustionSectionBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

// MARK: - Result Builder
@resultBuilder
public struct CombustionSectionBuilder {
    public static func buildBlock(_ components: ListItemCompatible...) -> [ListItemCompatible] {
        components
    }
    
    /// Handle conditional flows within the build block
    public static func buildOptional(_ component: [ListItemCompatible]?) -> [ListItemCompatible] {
        component ?? []
    }
    
    public static func buildEither(first component: [ListItemCompatible]) -> [ListItemCompatible] {
        component
    }
    
    public static func buildEither(second component: [ListItemCompatible]) -> [ListItemCompatible] {
        component
    }
    
    @ViewBuilder
    public static func buildFinalResult(_ components: [ListItemCompatible]) -> some View {
        let items = components.flatMap(\.items)
        let last = items.last
        
        // Build our list items
        ForEach(items, id: \.id) { item in
            VStack(spacing: 0) {
                if let destination = item.destination {
                    ListCell(destination: destination()) {
                        item.content()
                    }
                } else if let action = item.action {
                    ListCell(
                        action: action,
                        chevron: item.actionShowChevron
                    ) {
                        item.content()
                    }
                } else {
                    ListCell {
                        item.content()
                    }
                }
            }
            
            // Add our divider if the item is not last
            if item.id != last?.id {
                Divider()
                    .padding(.leading, 16)
            }
        }
    }
    
    /// Handle void code blocks with an empty argument list
    public static func buildExpression( _ expression: Void) -> [ListItemCompatible] {
        return []
    }
    
    /// Handle conversion of ListItemCompatible to `[ListItemCompatible]`
    public static func buildExpression( _ expression: ListItemCompatible) -> [ListItemCompatible] {
        return [expression]
    }
}

// MARK: - List item compatibles
public protocol ListItemCompatible {
    var items: [CombustionListItem] { get }
}

/// Convert our `CombustionListItem`s to a list of `CombustionListItem` so that
/// we can have the same `buildBlock` components and return arguments inside our
/// `CombustionSectionBuilder`.
///
/// Calling `\.items` will retrieve an array of `CombustionListItem` in order to build a final result.
extension CombustionListItem: ListItemCompatible {
    public var items: [CombustionListItem] {
        [self]
    }
}

/// Convert our `ListItemCompatable` arrays to a list of `CombustionListItem` so that
/// we can have the same `buildBlock` components and return arguments inside our
/// `CombustionSectionBuilder`.
///
/// Calling `\.items` will retrieve an array of `CombustionListItem` in order to build a final result.
extension Array: ListItemCompatible where Element == ListItemCompatible {
    public var items: [CombustionListItem] { self.flatMap(\.items) }
}

// MARK: - ForEach support

/// Conform our list items to View type for use within a `ForEach` as a 'View'
///
/// Since the `ForEach` within the DSL will not be used to render content, our view's
/// body type is Never. This ensures our `CombustionListItem` used inside a `ForEach`
/// will only be used by the appropriate result builder's `buildBlock` as Variadic Args.
extension CombustionListItem: View {
    public var body: Never { fatalError() }
}

/// Convert our ForEach's data into an array of '`CombustionListItem`
///
/// This converst the `Never` bodied `CombustionListItem` content from the
/// `ForEach` to an array of `CombustionListItem` which is used by the `buildBlock`
/// of the `CombustionSectionBuilder` DSL
extension ForEach: ListItemCompatible where Content == CombustionListItem {
    public var items: [CombustionListItem] {
        data.map(content)
    }
}
