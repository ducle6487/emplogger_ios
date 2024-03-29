//
//  NetworkProcessor.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import Foundation
import EmpLoggerCore

public protocol NetworkProcessor<Response>: ComposedLogging {
    associatedtype Response
    func process(_ request: URLRequest) -> AnyPublisher<Response, ApiError>
}

