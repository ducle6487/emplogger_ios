//
//  BaseColors.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

// MARK: - Kinetic color defaults

struct KineticLightColors: CombustionColors {
    var background: Color = ColorTokens.Neutrals.lightGrey
    var surface: Color = ColorTokens.Neutrals.white
    var error: Color = ColorTokens.Reds.emploggerRed
    
    var primary: Color = ColorTokens.Blues.emploggerBlue
    var primaryLightVariant: Color = ColorTokens.Blues.emploggerBlue60
    var primaryDarkVariant: Color = ColorTokens.Blues.emploggerBlueOver
    
    var secondary: Color = ColorTokens.Reds.emploggerRed
    var secondaryLightVariant: Color = ColorTokens.Reds.emploggerRed60
    var secondaryDarkVariant: Color = ColorTokens.Reds.emploggerRed
    
    var onBackground: Color = ColorTokens.Blacks.emploggerBlack
    var onSurface: Color = ColorTokens.Blacks.emploggerBlack
    var onError: Color = ColorTokens.Neutrals.white
    var onPrimary: Color = ColorTokens.Neutrals.white
    var onSecondary: Color = ColorTokens.Neutrals.white
}

struct KineticDarkColors: CombustionColors {
    var background: Color = ColorTokens.Blacks.emploggerBlack80
    var surface: Color = ColorTokens.Blacks.emploggerBlack
    var error: Color = ColorTokens.Reds.emploggerRed
    
    var primary: Color = ColorTokens.Blues.electricityBlue
    var primaryLightVariant: Color = ColorTokens.Blues.electricityBlue60
    var primaryDarkVariant: Color = ColorTokens.Blues.electricityBlueOver
    
    var secondary: Color = ColorTokens.Reds.emploggerRed
    var secondaryLightVariant: Color = ColorTokens.Reds.emploggerRed60
    var secondaryDarkVariant: Color = ColorTokens.Reds.emploggerRed
    
    var onBackground: Color = ColorTokens.Neutrals.white
    var onSurface: Color = ColorTokens.Neutrals.white
    var onError: Color = ColorTokens.Neutrals.white
    var onPrimary: Color = ColorTokens.Neutrals.white
    var onSecondary: Color = ColorTokens.Neutrals.white
}
