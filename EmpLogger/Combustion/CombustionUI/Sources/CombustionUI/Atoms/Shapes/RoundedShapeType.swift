//
//  RoundedShapeType.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion
import Foundation

public enum RoundedShapeType {
    case small
    case medium
    case large
    case extraLarge
    
    func cornerRadius(for theme: ThemeProvider) -> CGFloat {
        switch self {
        case .small:
            return theme.radius.small
        case .medium:
            return theme.radius.medium
        case .large:
            return theme.radius.large
        case .extraLarge:
            return theme.radius.extraLarge
        }
    }
}
