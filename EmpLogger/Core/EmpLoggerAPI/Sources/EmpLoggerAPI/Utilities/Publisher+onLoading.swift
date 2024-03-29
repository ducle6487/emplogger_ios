//
//  Publisher+onLoading.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine

extension Publisher where Failure == ApiError {
    public func onLoading(loadingBlock: @escaping () -> Void) -> AnyPublisher<Output, Failure> {
        self.handleEvents(receiveSubscription: { _ in
            loadingBlock()
        })
        .eraseToAnyPublisher()
    }
}
