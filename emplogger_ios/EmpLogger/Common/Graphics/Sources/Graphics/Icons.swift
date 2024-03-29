//
//  Icons.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

public struct Icons {
    public struct System {
        public static let checkmark: some View = Image(systemName: "checkmark")
            .font(.system(size: 17, weight: .semibold))
        public static let cross = Image(systemName: "xmark")
        public static let arrowRight = Image(systemName: "arrow.right")
        public static let share = Image(systemName: "square.and.arrow.up")
    }

    public struct Tabs {
        public static let home = Image("home")
        public static let homeSelected = Image("home_selected")
    }
}
