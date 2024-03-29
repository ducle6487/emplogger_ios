//
//  CombustionProgressBar.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct CombustionProgressBar: View {
    @EnvironmentObject var theme: ThemeProvider

    // MARK: - Instance Properties
    private var percentage: CGFloat

    // MARK: - Button Lifecycle

    /// Custom progress bar
    ///
    /// Progress bar component that can be reused throughout the application.
    ///
    /// - Parameters:
    ///     - percentage: Completed progress percentage. Controls width of 'loaded' overlay portion
    public init(percentage: CGFloat) {
        self.percentage = percentage
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: theme.radius.large)
                .fill(theme.colors.background)
                .frame(height: theme.spacing.comfortable)
            SingleAxisGeometryReader(alignment: .leading) { proxy in
                RoundedRectangle(cornerRadius: theme.radius.large)
                    .fill(theme.colors.primary)
                    .frame(width: proxy*percentage)
            }
        }
        .frame(height: theme.spacing.comfortable)
    }
}

// MARK: - Previews
struct CombustionProgressBar_Previews: PreviewProvider {
    @EnvironmentObject var theme: ThemeProvider
    static var previews: some View {
        HStack {
            Text("75%")
            CombustionProgressBar(percentage: 0.75)
        }
        .pageTheme(BaseTheme())
        .roundedCell(.white)
        .padding()
        .previewTheme(for: .light)
    }
}
