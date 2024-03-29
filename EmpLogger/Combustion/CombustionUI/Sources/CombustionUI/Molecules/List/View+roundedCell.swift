//
//  View+roundedCell.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

struct RoundedCellModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeProvider
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        RoundedShape(.extraLarge, padding: theme.spacing.cozy, backgroundColor: backgroundColor) {
            content
        }
    }
}

extension View {
    public func roundedCell(_ backgroundColor: Color = .clear) -> some View {
       modifier(RoundedCellModifier(backgroundColor: backgroundColor))
    }
}
