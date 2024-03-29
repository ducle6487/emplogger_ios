//
//  ThemeProvider.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

public class ThemeProvider: ObservableObject {
    @Published public private(set) var current: CombustionTheme = BaseTheme()
    
    // MARK: - Quick accessors for theme
    public var colors: CombustionColors { current.colors }
    public var spacing: CombustionSpacing { current.spacing }
    public var typograhpy: CombustionTypography { current.typography }
    public var radius: CombustionRadius { current.radius }
    public var motion: CombustionMotion { current.motion }
    public var isDarkMode: Bool {
        colorScheme == .dark
    }
    public var statusBarColor: UIStatusBarStyle {
        colorScheme == .light ? .darkContent : .lightContent
    }
    
    // MARK: - Private properties
    var colorScheme: ColorScheme = .light
    
    // MARK: - Color initialisation
    public init(with scheme: ColorScheme) {
        self.change(to: scheme)
    }
    
    // MARK: - Color switching
    public func change(to theme: any CombustionTheme) {
        self.current = theme
        setColors(from: colorScheme)
    }
    
    public func change(to scheme: ColorScheme) {
        guard scheme != colorScheme else { return }
        colorScheme = scheme
        setColors(from: scheme)
    }

    private func setColors(from scheme: ColorScheme) {
        switch scheme {
        case .light:
            current.colors = type(of: current).lightColors
        case .dark:
            current.colors = type(of: current).darkColors
        default:
            current.colors = type(of: current).lightColors
        }
    }
}
