//
//  Double+asCurrency.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension Double {
    public var asCurrency: String {
        String(format: "$%.2f", self)
    }
}
