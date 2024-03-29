//
//  CombustionButtonType.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public enum CombustionButtonType {
    case _primary(_ onSurface: Bool)
    case _secondary(_ onSurface: Bool)
    case _tertiary(_ onSurface: Bool)
    case tertiaryAlternative
    case primaryTextOnly
    case secondaryTextOnly
    case tertiaryTextOnly
    
    // MARK: - Button text colors
    func textColor(for theme: ThemeProvider, enabled: Bool) -> Color {
        enabled ? enabledTextColors(theme) : disabledTextColors(theme)
    }
    
    private func enabledTextColors(_ theme: ThemeProvider) -> Color {
        switch self {
        case ._primary:
            return theme.colors.onPrimary
        case ._secondary:
            return theme.colors.onSurface
        case ._tertiary:
            return theme.colors.onError
        case .tertiaryAlternative:
            return theme.colors.secondary
        case .primaryTextOnly:
            return theme.colors.primary
        case .secondaryTextOnly:
            return theme.colors.onPrimary
        case .tertiaryTextOnly:
            return theme.colors.secondary
        }
    }
    
    private func disabledTextColors(_ theme: ThemeProvider) -> Color {
        switch self {
        case ._primary:
            return theme.colors.onSurface.opacity(0.6)
        case ._secondary:
            return theme.colors.onSurface.opacity(0.6)
        case ._tertiary:
            return theme.colors.onError.opacity(0.6)
        case .tertiaryAlternative:
            return theme.colors.onSurface.opacity(0.6)
        case .primaryTextOnly:
            return theme.colors.primary.opacity(0.6)
        case .secondaryTextOnly:
            return theme.colors.onPrimary.opacity(0.6)
        case .tertiaryTextOnly:
            return theme.colors.onPrimary.opacity(0.6)
        }
    }
    
    // MARK: - Button background colors
    func backgroundColor(for theme: ThemeProvider, enabled: Bool) -> Color {
        enabled ? enabledBackgroundColors(theme) : disabledBackgroundColors(theme)
    }
    
    private func enabledBackgroundColors(_ theme: ThemeProvider) -> Color {
        switch self {
        case ._primary:
            return theme.colors.primary
        case ._secondary(let onSurface):
            return onSurface ? theme.colors.background : theme.colors.surface
        case ._tertiary:
            return theme.colors.error
        case .tertiaryAlternative:
            return theme.colors.surface
        case .primaryTextOnly:
            return .clear
        case .secondaryTextOnly:
            return .clear
        case .tertiaryTextOnly:
            return .clear
        }
    }
    
    private func disabledBackgroundColors(_ theme: ThemeProvider) -> Color {
        switch self {
        case ._primary(let onSurface):
            return (onSurface ? theme.colors.background : theme.colors.surface).opacity(0.6)
        case ._secondary(let onSurface):
            return (onSurface ? theme.colors.background : theme.colors.surface).opacity(0.6)
        case ._tertiary(let onSurface):
            return (onSurface ? theme.colors.background : theme.colors.surface).opacity(0.6)
        case .tertiaryAlternative:
            return theme.colors.surface
        case .primaryTextOnly:
            return .clear
        case .secondaryTextOnly:
            return .clear
        case .tertiaryTextOnly:
            return .clear
        }
    }
}

// MARK: - On surface convenience inits
extension CombustionButtonType {
    // MARK: - Primary Conveniences
    /// Convenience accessor for secondary button type without a parameter
    public static var primary: CombustionButtonType {
        primary()
    }
    
    public static func primary(onSurface: Bool = false) -> CombustionButtonType {
        ._primary(onSurface)
    }
    
    // MARK: - Secondary Conveniences
    /// Convenience accessor for secondary button type without a parameter
    public static var secondary: CombustionButtonType {
        secondary()
    }
    
    public static func secondary(onSurface: Bool = false) -> CombustionButtonType {
        ._secondary(onSurface)
    }
    
    // MARK: - Tertiary Conveniences
    /// Convenience accessor for secondary button type without a parameter
    public static var tertiary: CombustionButtonType {
        tertiary()
    }
    
    public static func tertiary(onSurface: Bool = false) -> CombustionButtonType {
        ._tertiary(onSurface)
    }
}
