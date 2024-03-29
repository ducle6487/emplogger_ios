//
//  OptionalCollection+containsOrFalse.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

import Foundation

extension Optional where Wrapped: Collection {
    @inlinable public func containsOrFalse(where predicate: @escaping (Wrapped.Element) -> Bool) -> Bool {
        self?.contains(where: predicate) ?? false
    }
}
