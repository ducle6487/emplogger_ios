//
//  Float+asCurrency.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension Float {
    public var asCurrency: String {
        String(format: "$%.0f", self)
    }
}
