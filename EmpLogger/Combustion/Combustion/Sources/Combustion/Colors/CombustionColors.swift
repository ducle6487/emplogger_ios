//
//  CombustionColors.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

public protocol CombustionColors {
    var background: Color { get }
    var surface: Color { get }
    var error: Color { get }
    
    var primary: Color { get }
    var primaryLightVariant: Color { get }
    var primaryDarkVariant: Color { get }
    
    var secondary: Color { get }
    var secondaryLightVariant: Color { get }
    var secondaryDarkVariant: Color { get }
    
    // Foregrounds
    var onBackground: Color { get }
    var onSurface: Color { get }
    var onError: Color { get }
    var onPrimary: Color { get }
    var onSecondary: Color { get }
}
