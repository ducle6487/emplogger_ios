//
//  Repository+perform.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation

public protocol Repository {
    func perform<Decode: Decodable>(_ method: HttpMethod, builder: RequestBuilder) -> AnyPublisher<Decode, ApiError>
}

extension Repository {
    
    /// Builds a network request and processes it
    ///
    /// Creates a request with the appropriate `HttpMethod` and processes
    /// the request
    ///
    /// - Parameters:
    ///     - method:  The `HttpMethod` to be used with the request
    ///     - builder: A `RequestBuilder` to be used for building the base request
    ///
    ///  - Returns: A publisher with the decodable type provided by user, and ApiError as failure
    public func perform<Decode: Decodable>(
        _ method: HttpMethod,
        builder: RequestBuilder
    ) -> AnyPublisher<Decode, ApiError> {
        do {
            // Wrap our builder with the provided method and process
            let request = try RequestMethodBuilder(
                method: method,
                builder: builder
            )
            .build()
            
            return process(request)
        } catch let err {
            // Catch our url building errors and map them to other
            return Fail(error: ApiError.other(error: err)).eraseToAnyPublisher()
        }
    }
    
    /// Builds a network request and processes it
    ///
    /// Creates a request with the appropriate `HttpMethod` and processes
    /// the request
    ///
    /// - Parameters:
    ///     - method:  The `HttpMethod` to be used with the request
    ///     - builder: A `RequestBuilder` to be used for building the base request
    ///
    ///  - Returns: A publisher with the decodable type provided by user, and ApiError as failure
    public func perform(
        _ method: HttpMethod,
        builder: RequestBuilder
    ) -> AnyPublisher<NetworkResponse, ApiError> {
        do {
            // Wrap our builder with the provided method and process
            let request = try RequestMethodBuilder(
                method: method,
                builder: builder
            )
            .build()
            
            return process(request)
        } catch let err {
            // Catch our url building errors and map them to other
            return Fail(error: ApiError.other(error: err)).eraseToAnyPublisher()
        }
    }
    
    /// Processes a network request
    ///
    /// Decorates a request with a network processor to create a
    /// network publisher for the provided request.
    ///
    /// - Parameters:
    ///     - request:  A url request to perform the network request with
    ///
    ///  - Returns: A publisher with the decodable type provided by user, and ApiError as failure
    func process<Decode: Decodable>(_ request: URLRequest) -> AnyPublisher<Decode, ApiError> {
        let processor = DecodeProcessor<Decode>(
            processor: ResponseProcessor(
                processor: DataTaskProcessor()
            )
        )
        return processor.process(request)
    }
    
    /// Processes a network request
    ///
    /// Decorates a request with a network processor to create a
    /// network publisher for the provided request.
    ///
    /// - Parameters:
    ///     - request:  A url request to perform the network request with
    ///
    ///  - Returns: A publisher with the decodable type provided by user, and ApiError as failure
    func process(_ request: URLRequest) -> AnyPublisher<NetworkResponse, ApiError> {
        let processor = ResponseProcessor(
            processor: DataTaskProcessor()
        )
        return processor.process(request)
    }
}
