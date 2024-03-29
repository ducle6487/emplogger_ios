//
//  CombustionSpacing.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public protocol CombustionSpacing {
    var none: CGFloat { get }
    /// Smallest spacing used in small related components i.e. Spacing around an image in a small box
    var tight: CGFloat { get }
    /// Minor spacing between related components, i.e. Title and description
    var squishy: CGFloat { get }
    /// Spacing between related groups of components, i.e. An image above a text block
    var compact: CGFloat { get }
    /// Default spacing for internal insets and spacing within components
    var cozy: CGFloat { get }
    /// Default spacing and margin for pages and component gutters
    var comfortable: CGFloat { get }
    /// Spacing between larger components or clearly separating unrelated components from each other
    var roomy: CGFloat { get }
    /// Are we sure we even need this?
    var spacious: CGFloat { get }
}
