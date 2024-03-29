//
//  String+isNumber.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

extension String {

    public var isNumber: Bool {
        self.allSatisfy { $0.isNumber }
    }

    public var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
