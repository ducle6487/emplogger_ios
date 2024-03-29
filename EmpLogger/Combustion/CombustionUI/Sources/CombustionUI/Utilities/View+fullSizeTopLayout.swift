//
//  View+fullSizeTopLayout.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

extension View {
    public func fullSizeTopLayout() -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
