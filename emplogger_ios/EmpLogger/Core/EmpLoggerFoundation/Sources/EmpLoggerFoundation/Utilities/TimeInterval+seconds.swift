//
//  TimeInterval+seconds.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension TimeInterval {
    public var seconds: Int {
        return Int(self.rounded())
    }

    public var milliseconds: Int {
        return Int(self * 1_000)
    }
}
