//
//  CombustionListBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

// MARK: - Result Builder
@resultBuilder
public struct CombustionListBuilder {
    public static func buildBlock(_ components: CombustionListCompatible...) -> [CombustionListCompatible] {
        components
    }
    
    /// Handle conditional flows within the build block
    public static func buildOptional(_ component: [CombustionListCompatible]?) -> [CombustionListCompatible] {
        component ?? []
    }
    
    public static func buildEither(first component: [CombustionListCompatible]) -> [CombustionListCompatible] {
        component
    }
    
    public static func buildEither(second component: [CombustionListCompatible]) -> [CombustionListCompatible] {
        component
    }
    
    @ViewBuilder
    public static func buildFinalResult(_ components: [CombustionListCompatible]) -> some View {
        let items = components.flatMap(\.list)
        
        // Build our list items
        ForEach(items, id: \.id) { item in
            item
        }
    }
    
    /// Handle void code blocks with an empty argument list
    public static func buildExpression( _ expression: Void) -> [CombustionListCompatible] {
        return []
    }
    
    /// Handle conversion of ListItemCompatible to `[CombustionListCompatible]`
    public static func buildExpression( _ expression: CombustionListCompatible) -> [CombustionListCompatible] {
        return [expression]
    }
    
    public static func buildExpression(_ expression: CombustionListItem) -> [CombustionListCompatible] {
        [CombustionListSection { expression }]
    }
}

// MARK: - List item compatibles
public protocol CombustionListCompatible {
    var list: [CombustionListSection] { get }
}

/// Convert our `CombustionListItem`s to a list of `CombustionListItem` so that
/// we can have the same `buildBlock` components and return arguments inside our
/// `CombustionSectionBuilder`.
///
/// Calling `\.items` will retrieve an array of `CombustionListItem` in order to build a final result.
extension CombustionListSection: CombustionListCompatible {
    public var list: [CombustionListSection] {
        [self]
    }
}

/// Convert our `ListItemCompatable` arrays to a list of `CombustionListItem` so that
/// we can have the same `buildBlock` components and return arguments inside our
/// `CombustionSectionBuilder`.
///
/// Calling `\.items` will retrieve an array of `CombustionListItem` in order to build a final result.
extension Array: CombustionListCompatible where Element == CombustionListCompatible {
    public var list: [CombustionListSection] { self.flatMap(\.list) }
}

// MARK: - ForEach support

/// Convert our ForEach's data into an array of '`CombustionListItem`
///
/// This converst the `Never` bodied `CombustionListItem` content from the
/// `ForEach` to an array of `CombustionListItem` which is used by the `buildBlock`
/// of the `CombustionSectionBuilder` DSL
extension ForEach: CombustionListCompatible where Content == CombustionListSection {
    public var list: [CombustionListSection] {
        data.map(content)
    }
}
