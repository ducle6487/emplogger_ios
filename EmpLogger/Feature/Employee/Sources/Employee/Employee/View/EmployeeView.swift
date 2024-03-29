//
//  EmployeeView.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI

public struct EmployeeView: View {
    @EnvironmentObject private var theme: ThemeProvider
    
    public var body: some View {
        Text("Employee")
    }
}

struct EmployeeView_Preview: PreviewProvider {
    static var previews: some View {
        EmployeeView()
            .previewTheme(for: .light)
    }
}
