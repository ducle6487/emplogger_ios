//
//  PlaceholderText.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct PlaceholderText: View {
    @EnvironmentObject var theme: ThemeProvider
    @State var textSize: CGSize = CGSize(width: 1, height: 1)
    var font: Font
    var width: CGFloat?
    var color: Color?
    
    public init(font: Font, width: CGFloat? = nil, color: Color? = nil) {
        self.font = font
        self.width = width
        self.color = color
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: theme.radius.large)
            .foregroundColor(color ?? theme.colors.background)
            .frame(maxWidth: width ?? .infinity)
            .frame(height: textSize.height)
            .overlay(
                ChildGeometryReader(size: $textSize) {
                    Text("placeholder").font(font)
                }
                .opacity(0)
            )
    }
}

struct PlaceholderPreviews: PreviewProvider {
    static var previews: some View {
        RoundedShape(.extraLarge) {
            VStack(spacing: 12) {
                PlaceholderText(font: .largeTitle)
                PlaceholderText(font: .title)
                PlaceholderText(font: .body)
                PlaceholderText(font: .callout)
            }
        }
            .shimmering()
            .padding(.horizontal, 16)
            .previewTheme(for: .light)
    }
}
