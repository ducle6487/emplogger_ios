//
//  Publisher+mapEvents.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation

extension Publisher where Failure == ApiError {
    /// Map our publisher events and results to completion handlers
    ///
    /// Since an inout StoreState cannot be captured in an escaping closure
    /// State update callbacks can be passed in instead.
    public func mapEvents(
        successBlock: @escaping (Output) -> Void,
        loadingBlock: @escaping () -> Void,
        errorBlock: @escaping (ApiError) -> Void
    ) -> AnyCancellable {
        self.handleEvents(
            // Start loading on initial subscription
            receiveSubscription: { _ in
                // Run our block on the main thread as it will typically fire state changes
                Task { @MainActor in
                    loadingBlock()
                }
            }
        )
        .sink { completion in
            // Errors will automatically complete
            switch completion {
            case .finished:
                break
            case .failure(let error):
                errorBlock(error)
            }
        } receiveValue: { output in
            // Forward our success
            successBlock(output)
        }
    }
}
