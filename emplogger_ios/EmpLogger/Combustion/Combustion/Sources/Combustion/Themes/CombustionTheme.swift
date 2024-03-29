//
//  CombustionTheme.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

public protocol ColorSchemeConformable {
    static var lightColors: CombustionColors { get }
    static var darkColors: CombustionColors { get }
}

public protocol CombustionTheme: ColorSchemeConformable {
    var colors: CombustionColors { get set }
    var spacing: CombustionSpacing { get set }
    var typography: CombustionTypography { get set }
    var radius: CombustionRadius { get set }
    var motion: CombustionMotion { get set }
}

public struct BaseTheme: CombustionTheme {
    public static var lightColors: CombustionColors = KineticLightColors()
    public static var darkColors: CombustionColors = KineticDarkColors()
    public var colors: CombustionColors = lightColors
    public var spacing: CombustionSpacing = BaseSpacing()
    public var typography: CombustionTypography = BaseTypography()
    public var radius: CombustionRadius = BaseRadius()
    public var motion: CombustionMotion = BaseMotion()
    public init() {}
}
