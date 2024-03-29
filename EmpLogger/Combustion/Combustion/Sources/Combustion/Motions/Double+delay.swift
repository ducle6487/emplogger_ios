//
//  Double+delay.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

// MARK: - Delays
extension Double {
    public static var delayFast: Double {
        DurationTokens.fast
    }
    public static var delayMedium: Double {
        DurationTokens.medium
    }
    public static var delaySlow: Double {
        DurationTokens.slow
    }
}
