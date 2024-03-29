//
//  ScaledOpacityButtonStyle.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct ScaledOpacityButtonStyle: ButtonStyle {
    @EnvironmentObject var theme: ThemeProvider
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(theme.motion.easeInOutFast, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == ScaledOpacityButtonStyle {
    public static var scaledOpacity: ScaledOpacityButtonStyle {
        ScaledOpacityButtonStyle()
    }
}
