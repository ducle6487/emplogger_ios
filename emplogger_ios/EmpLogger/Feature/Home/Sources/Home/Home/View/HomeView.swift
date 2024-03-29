//
//  HomeView.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI

public struct HomeView: View {
    @EnvironmentObject private var theme: ThemeProvider
    
    public var body: some View {
        Text("Home")
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewTheme(for: .light)
    }
}
