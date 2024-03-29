//
//  ScaledButtonStyle.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct ScaledButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: ThemeProvider
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(theme.motion.easeInOutMedium, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScaledButtonStyle {
    public static var scaled: ScaledButtonStyle {
        ScaledButtonStyle()
    }
}
