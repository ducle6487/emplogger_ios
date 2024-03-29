//
//  Publisher+toAsync.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Combine

extension Publishers {
    enum AsyncError: Error {
        case noOutput
    }
}

extension Publisher {
    @discardableResult public func toAsync() async throws -> Output {
        var cancellable: AnyCancellable?
        var didReceiveValue = false

        return try await withCheckedThrowingContinuation { continuation in
            cancellable = sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .finished:
                        // If we did not receive a value thorw an error
                        if !didReceiveValue {
                            continuation.resume(
                                throwing: Publishers.AsyncError.noOutput
                            )
                        }
                    }
                },
                receiveValue: { value in
                    // Only publish our first value to the asnyc function
                    guard !didReceiveValue else { return }

                    didReceiveValue = true

                    // Deallocate our cancellable from async scope
                    cancellable?.cancel()

                    // Return our value
                    continuation.resume(returning: value)
                }
            )
        }
    }
}
