//
//  NewsView.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI

public struct NewsView: View {
    @EnvironmentObject private var theme: ThemeProvider
    
    public var body: some View {
        Text("News")
    }
}

struct NewsView_Preview: PreviewProvider {
    static var previews: some View {
        NewsView()
            .previewTheme(for: .light)
    }
}
