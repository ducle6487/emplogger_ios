//
//  DataTaskProcessor.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation
import EmpLoggerCore
import EmpLoggerInjection

public struct DataTaskProcessor: NetworkProcessor {
    @Inject(\.urlSession) var urlSession: URLSession
    
    public init() {}
    
    public func process(_ request: URLRequest) -> AnyPublisher<NetworkResponse, ApiError> {
        log("Creating dataTaskPublisher for request:", request, component: .network)
        return urlSession.dataTaskPublisher(for: request)
            // Map our response type to a `NetworkResponse`
            // so we can generalise our mapping of data in other decorators
            .map({ NetworkResponse(data: $0.data, response: $0.response) })
            .mapErrorAndErase()
    }
}
