//
//  NavBuilder.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import SwiftUI

/// NavBuilder for building `Tab` collections in a declarative way
///
/// Enables the use of declarative building inside a result builder block.
/// Allowing control statements to be used and feature flags to be used in the building of a list
///
/// The following code creates a list of `Tabs` for use in the navigation view:
///
///     @NavBuilder var tabs: [Tab] {
///         Tab(...)
///         Tab(...)
///         if someCondition { Tab(...) }
///         Tab(...)
///     }
///
/// The above simplifies the following equivalent:
///
///     var navItems: [NavItem] {
///         var items = [
///             Tab(...),
///             Tab(...),
///             Tab(...),
///         ]
///
///         if someCondition {
///             items.insert(Tab(...), at: 2)
///         }
///
///         return items
///     }
@resultBuilder
public struct NavBuilder {
    public static func buildBlock(_ components: [Tab]...) -> [Tab] {
        components.flatMap { $0 }
    }

    // Support for both single and collections of constraints.
    public static func buildExpression(_ expression: Tab) -> [Tab] {
        [expression]
    }

    public static func buildExpression(_ expression: [Tab]) -> [Tab] {
        expression
    }

    // Support for optionals.
    public static func buildOptional(_ components: [Tab]?) -> [Tab] {
        components ?? []
    }

    // Support for if statements.
    public static func buildEither(first components: [Tab]) -> [Tab] {
        components
    }

    public static func buildEither(second components: [Tab]) -> [Tab] {
        components
    }
    
    // Support for for loops
    public static func buildArray(_ components: [[Tab]]) -> [Tab] {
        components.flatMap { $0 }
    }
}
