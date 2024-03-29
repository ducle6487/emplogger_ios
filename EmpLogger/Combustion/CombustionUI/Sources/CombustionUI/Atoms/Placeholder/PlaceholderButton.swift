//
//  PlaceholderButton.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct PlaceholderButton: View {
    @EnvironmentObject var theme: ThemeProvider
    
    public init() {}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: theme.radius.large)
            .foregroundColor(theme.colors.background)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
    }
}

struct PlaceholderButtonPreviews: PreviewProvider {
    static var previews: some View {
        PlaceholderButton()
            .previewTheme(for: .light)
    }
}
