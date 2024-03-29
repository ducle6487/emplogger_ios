//
//  HeaderPage.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct HeaderPage<Header: View, Content: View>: View {
    @EnvironmentObject private var theme: ThemeProvider
    var content: Content
    var header: Header
    
    public init(@ViewBuilder content: () -> Content, @ViewBuilder header: () -> Header) {
        self.content = content()
        self.header = header()
    }
    
    public var body: some View {
        Page {
            VStack(spacing: 0) {
                headerContent
                content
            }
            .fullSizeTopLayout()
        }
    }
}

// MARK: - Header
extension HeaderPage {
    var headerContent: some View {
        ZStack(alignment: .bottomLeading) {
            theme.colors.surface
                .edgesIgnoringSafeArea(.top)
                .frame(maxHeight: 80)
            
            header
                .foregroundColor(theme.colors.onSurface)
        }
    }
}

// MARK: - Previews
struct HeaderPage_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPage {
            Text("Page body")
        } header: {
            Text("Page title")
                .font(.title)
                .bold()
                .padding()
        }
        .previewTheme(for: .light)
    }
}
