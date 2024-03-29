//
//  OnBoardView.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI

public struct OnBoardView: View {
    @EnvironmentObject private var theme: ThemeProvider
    
    public var body: some View {
        Text("OnBoard")
    }
}

struct OnBoardView_Preview: PreviewProvider {
    static var previews: some View {
        OnBoardView()
            .previewTheme(for: .light)
    }
}
