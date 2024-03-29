//
//  OptionalCollection+count.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

extension Optional where Wrapped: Collection {
    public var countOrNone: Int {
        self?.count ?? 0
    }
}
