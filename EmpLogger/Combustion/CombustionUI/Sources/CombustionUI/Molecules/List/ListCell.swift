//
//  ListCell.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

struct ListCell<Content: View>: View {
    typealias CellAction = () -> Void
    
    @EnvironmentObject private var theme: ThemeProvider
    var content: Content
    var action: CellAction?
    var actionChevron: Bool = false
    var destination: (() -> AnyView)?
    
    @State var childSize: CGSize = CGSize(width: 1, height: 50)
    
    /// Init that provides an autoclosure for clean call site
    init(
        action: @autoclosure @escaping CellAction,
        chevron: Bool = false,
        content: () -> Content
    ) {
        self.action = action
        self.actionChevron = chevron
        self.content = content()
    }
    
    /// Init that takes a nullable action for cell items without an action or
    init(
        action: CellAction? = nil,
        chevron: Bool = false,
        content: () -> Content
    ) {
        self.action = action
        self.actionChevron = chevron
        self.content = content()
    }
    
    /// Init that takes a destination for cell items without an action or
    init(
        destination: some View,
        content: () -> Content
    ) {
        self.destination = { AnyView(destination) }
        self.content = content()
    }
    
    var body: some View {
        ChildGeometryReader(size: $childSize) {
            Group {
                if let action {
                    // Only render button if action exists
                    Button(action: action) {
                        cell
                    }
                } else {
                    cell
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: childSize.height)
    }
    
    @ViewBuilder
    var cell: some View {
        // Register navlink if destination exists
        if let destination {
            NavigationLink(destination: destination) {
                ZStack {
                    theme.colors.surface
                    cellContent
                }
            }
        } else {
            ZStack {
                theme.colors.surface
                cellContent
            }
        }
    }
    
    var cellContent: some View {
        HStack(alignment: .center, spacing: theme.spacing.cozy) {
            content
            Spacer()
            if destination != nil || actionChevron {
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .padding(.trailing, theme.spacing.cozy)
                    .foregroundColor(theme.colors.onSurface)
                    .opacity(0.6)
            }
        }
        .foregroundColor(theme.colors.onSurface)
        .padding(.leading, theme.spacing.comfortable)
        .padding(.vertical, theme.spacing.comfortable)
    }
}

// MARK: - Previews
struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(action: {}) {
            Text("Some content")
        }
        .previewTheme(for: .light)
    }
}
