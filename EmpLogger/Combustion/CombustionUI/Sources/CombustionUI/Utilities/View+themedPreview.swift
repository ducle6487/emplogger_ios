//
//  View+themedPreview.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

extension View {
    private func provideTheme(for scheme: ColorScheme) -> ThemeProvider {
        ThemeProvider(with: scheme)
    }
    
    public func previewTheme(for scheme: ColorScheme) -> some View {
        let theme = provideTheme(for: scheme)
        return ZStack {
            theme.colors.background
                .ignoresSafeArea()
                .preferredColorScheme(scheme)
            
            self.environmentObject(theme)
        }
    }
}
