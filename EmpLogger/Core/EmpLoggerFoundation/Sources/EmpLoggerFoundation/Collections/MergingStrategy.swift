//
//  MergingStrategy.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

import Foundation

public enum MergingStrategy<Value> { }

public extension MergingStrategy {
    typealias KeepOld = Value
    typealias OverwriteOld = Value

    /// Overwrite the original value.
    static var overwrite: (KeepOld, OverwriteOld) -> Value {
        { _, new in new }
    }
    
    /// Keep the original value.
    static var keepOld: (KeepOld, OverwriteOld) -> Value {
        { old, _ in old }
    }
}
