//
//  Collection+largest.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

extension Collection {
    /// Finds the object in a collection with the largest value for a given key path.
    ///
    /// - Parameters:
    ///   - by: The key path to the property to compare.
    ///
    /// - Returns: The object with the largest value for the given key path, or `nil` if the collection is empty.
    public func largest<V: Comparable>(by keyPath: KeyPath<Element, V>) -> Element? {
        return self.max { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}

