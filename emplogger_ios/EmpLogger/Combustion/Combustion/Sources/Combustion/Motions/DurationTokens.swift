//
//  DurationTokens.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

internal struct DurationTokens {
    /// Duration for animations that should not slow down the user's interaction
    static let fast: CGFloat = 0.1
    /// Duration for animations that should catch a user's attention
    static let medium: CGFloat = 0.2
    /// Duration for animations that are longer running and block the user's interaction
    static let slow: CGFloat = 0.4
}
