//
//  Error+asPublisher.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine

extension Error {
    public func asPublisher<T>() -> AnyPublisher<T, Self> {
        return Fail(error: self).eraseToAnyPublisher()
    }
}

