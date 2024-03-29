//
//  Collection+at.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

extension Collection {
    /// Access element with index use `.at(index)` instead of `.[index]`
    public func at(_ index: Self.Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
