//
//  KeyboardStyle.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Foundation

public enum KeyboardStyle {
    case phoneNumber
    case email
    case numeric
    case generic
}

extension KeyboardStyle {
    var keyboardType: UIKeyboardType {
        switch self {
        case .phoneNumber: return .phonePad
        case .email: return .emailAddress
        case .numeric: return .numberPad
        case .generic: return .default
        }
    }
    
    var autoCapitalization: TextInputAutocapitalization {
        switch self {
        case .generic: return .sentences
        default: return .never
        }
    }
}
