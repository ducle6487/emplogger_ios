//
//  RoundedShape.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Foundation
import Combustion

public struct RoundedShape<Content: View>: View {
    @EnvironmentObject var theme: ThemeProvider
    var shapeType: RoundedShapeType
    var padding: CGFloat?
    var backgroundColor: Color?
    var content: Content
    
    public init(
        _ shapeType: RoundedShapeType,
        padding: CGFloat? = nil,
        backgroundColor: Color? = nil,
        content: () -> Content
    ) {
        self.shapeType = shapeType
        self.content = content()
        self.padding = padding
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        content
            .foregroundColor(theme.colors.onSurface)
            .padding(padding ?? theme.spacing.cozy)
            .cornerRadius(shapeType.cornerRadius(for: theme))
            .background(
                Rectangle()
                    .cornerRadius(shapeType.cornerRadius(for: theme))
                    .foregroundColor(backgroundColor ?? theme.colors.surface)
            )
    }
}

// MARK: - Previews
struct RoundedShape_Previews: PreviewProvider {
    static var previews: some View {
        RoundedShape(.medium) {
            Text("Rounded shape")
        }
        .previewTheme(for: .light)
        
        RoundedShape(.large) {
            RoundedShape(.medium, padding: .zero) {
                Color.blue
                    .frame(height: 150)
            }
        }
        .padding()
        .previewTheme(for: .light)
    }
}
