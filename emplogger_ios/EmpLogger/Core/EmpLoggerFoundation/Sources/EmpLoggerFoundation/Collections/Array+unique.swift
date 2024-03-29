//
//  Array+unique.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//


public extension Array where Element: Hashable {
    /// Make array element unique
    var unique: [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
