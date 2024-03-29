//
//  ResponseProcessor.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation
import EmpLoggerInjection

public struct ResponseProcessor: NetworkProcessor {
    
    var customCodes: [Int]
    var processor: any NetworkProcessor<NetworkResponse>
    
    public init(customCodes: [Int] = [], processor: some NetworkProcessor<NetworkResponse>) {
        self.customCodes = customCodes
        self.processor = processor
    }
    
    public func process(_ request: URLRequest) -> AnyPublisher<NetworkResponse, ApiError> {
        processor.process(request)
            .tryMap { response in
                log("Parsing API response:", response, component: .network)
                let parsed = try ApiResponseParser.parse(response, customCodes: customCodes)
                return parsed
            }
            .mapErrorAndErase()
    }
}
