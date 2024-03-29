//
//  Future+fromAsync.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Combine

extension Future where Failure == Error {
    public static func from(async: @escaping () async throws -> Output) -> AnyPublisher<Output, Failure> {
        return Future<Output, Failure> { promise in
            Task {
                do {
                    let result = try await async()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
