//
//  Bool+apply.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

public extension Bool {
    func apply(_ closure: () -> Void) {
        if self {
            closure()
        }
    }
}

public extension Optional where Wrapped == Bool {
    func apply(_ closure: () -> Void) {
        self?.apply(closure)
    }
}
