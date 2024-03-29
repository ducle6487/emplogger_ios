//
//  Processor.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

/// Simple processor for use in a decorator / proxy pattern
///
/// Decorator method that processes a value without mutation
internal protocol ValueProcessor<Value> {
    associatedtype Value
    func process(_ value: Value) -> Value
}
