//
//  BaseSpacing.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

// MARK: - Spacing defaults

internal struct BaseSpacing: CombustionSpacing {
    /// Zero spacing between components
    var none: CGFloat = .zero
    /// Smallest spacing used in small related components i.e. Spacing around an image in a small box
    var tight: CGFloat = SpacingTokens.tight
    /// Minor spacing between related components, i.e. Title and description
    var squishy: CGFloat = SpacingTokens.squishy
    /// Spacing between related groups of components, i.e. An image above a text block
    var compact: CGFloat = SpacingTokens.compact
    /// Default spacing for internal insets and spacing within components
    var cozy: CGFloat = SpacingTokens.cozy
    /// Default spacing and margin for pages and component gutters
    var comfortable: CGFloat = SpacingTokens.comfortable
    /// Spacing between larger components or clearly separating unrelated components from each other
    var roomy: CGFloat = SpacingTokens.roomy
    /// Are we sure we even need this?
    var spacious: CGFloat = SpacingTokens.spacious
}
