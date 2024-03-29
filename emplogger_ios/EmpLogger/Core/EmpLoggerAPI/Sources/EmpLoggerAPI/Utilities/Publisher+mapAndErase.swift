//
//  Publisher+mapAndErase.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation
import EmpLoggerCore
import EmpLoggerInjection

struct ComposedLoggingProxy: ComposedLogging {}
extension Publisher {
    /// Erases a publisher to `AnyPublisher` and maps its error type to `ApiError`
    ///
    /// For reuse within the network layer to erase our error chains to ApiError.
    /// Any `Error` or other error type if not directyl an `ApiError` will be wrapped
    /// as an `ApiError.other` in order to preserve a single response type through
    /// our network decorators.
public func mapErrorAndErase() -> AnyPublisher<Output, ApiError> {
        // map our errors
        return self.mapError { error -> ApiError in
            switch error {
            case let apiError as ApiError:
                ComposedLoggingProxy.log("ApiError: \(error)", .network, level: .error)
                return apiError
            case is DecodingError:
                ComposedLoggingProxy.log("Decoding error: \(error)", .network, level: .error)
                return ApiError.parsing
            case let urlError as URLError:
                return mapURLError(error: urlError)
            default:
                ComposedLoggingProxy.log("Other error: \(error)", .network, level: .error)
                return ApiError.other(error: error)
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func mapURLError(error: URLError) -> ApiError {
        switch error.errorCode {
        case URLError.Code.notConnectedToInternet.rawValue:
            ComposedLoggingProxy.log("No connection error: \(error)", .network, level: .error)
            return ApiError.connection
        case URLError.Code.timedOut.rawValue:
            ComposedLoggingProxy.log("Timeout error: \(error)", .network, level: .error)
            return ApiError.timeout
        default:
            ComposedLoggingProxy.log("Other error: \(error)", .network, level: .error)
            return ApiError.other(error: error)
        }
    }
}
