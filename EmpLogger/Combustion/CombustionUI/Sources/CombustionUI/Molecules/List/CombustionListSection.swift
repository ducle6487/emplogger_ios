//
//  CombustionListSection.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

/// Combustion List Section wrapper
///
/// For wrapping `CombustionSectionBuilder`s and adding section title functionality.
/// Composes the `CombustionList` content into a section.
public struct CombustionListSection: View {
    @EnvironmentObject var theme: ThemeProvider
    var id = UUID()
    private var title: String?
    private var disableInset: Bool
    private var content: AnyView
    private var header: AnyView?
    private var headerInside: Bool
    private var font: Font = .caption

    public init(
        _ title: String? = nil,
        font: Font = .caption,
        disableInset: Bool = false,
        @CombustionSectionBuilder content: () -> some View
    ) {
        self.title = title
        self.font = font
        self.disableInset = disableInset
        self.content = AnyView(content())
        self.header = nil
        self.headerInside = false
    }
    
    public init(
        headerInside: Bool = false,
        disableInset: Bool = false,
        _ header: () -> some View,
        @CombustionSectionBuilder content: () -> some View
    ) {
        self.title = nil
        self.headerInside = headerInside
        self.disableInset = disableInset
        self.content = AnyView(content())
        self.header = AnyView(header())
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title {
                Text(title)
                    .font(self.font)
                    .padding(theme.spacing.cozy)
                    .foregroundColor(theme.colors.onBackground.opacity(0.6))
                    .padding(.horizontal, theme.spacing.comfortable)
            }
            
            if !headerInside {
                headerView
                    .padding(theme.spacing.cozy)
                    .padding(.horizontal, theme.spacing.comfortable)
            }
                    
            RoundedShape(.extraLarge, padding: 0, backgroundColor: .clear) {
                VStack(spacing: 0) {
                    if headerInside {
                        headerView
                            .padding(.top, theme.spacing.comfortable)
                            .padding(.horizontal, theme.spacing.comfortable)
                            .background(theme.colors.surface)
                    }
                    
                    content
                }
            }
            .padding(.horizontal, disableInset ? 0 : theme.spacing.comfortable)
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        if let header {
            HStack { header }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
