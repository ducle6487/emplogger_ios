//
//  DecodeProcessor.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation
import EmpLoggerInjection

public struct DecodeProcessor<Decode: Decodable>: NetworkProcessor {
    @Inject(\.baseJsonDecoder) var jsonDecoder: JSONDecoder
    var processor: any NetworkProcessor<NetworkResponse>
    
    public init(processor: some NetworkProcessor<NetworkResponse>) {
        self.processor = processor
    }
    
    public func process(_ request: URLRequest) -> AnyPublisher<Decode, ApiError> {
        return processor.process(request)
            .handleEvents(receiveOutput: { response in
                let data = String(decoding: response.data, as: UTF8.self)
                
                if data.contains("content_type") {
                    return log("Decoding content response:", data, "of type: '\(Decode.self)'", component: .content)
                }
                
                log("Decoding API response:", data, "to type: \(Decode.self)", component: .network)
            })
            .map(\.data)
            .decode(type: Decode.self, decoder: jsonDecoder)
            .mapErrorAndErase()
    }
}
