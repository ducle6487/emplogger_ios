//
//  ProfileView.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI

public struct ProfileView: View {
    @EnvironmentObject private var theme: ThemeProvider

    public var body: some View {
        Text( "Profile")
    }
}

struct ProfileView_Preview: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewTheme(for: .light)
    }
}
