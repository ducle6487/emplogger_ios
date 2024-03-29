//
//  XCTest+mockRequest.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import XCTest
import Foundation
import EmpLoggerInjection
import EmpLoggerFoundation

extension XCTest {
    public func mock(
        request: URLRequest,
        with object: some Encodable,
        response: HTTPURLResponse = HTTPURLResponse.with(statusCode: 200)
    ) -> URLSession {
        let data = encodeMock(object: object)

        // Add our mock data and response to the network stub dictionary for recall
        // overwriting any duplicate stubs already configured
        URLProtocolStub.stubUrls = URLProtocolStub.stubUrls.merging(
            [request.url: (data: data, response: response, error: nil)],
            uniquingKeysWith: MergingStrategy.overwrite
        )
        
        // Create our mock session config and attach our URLProtocolStub for stubbing
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        
        // Return our mocked urls session config
        return URLSession(configuration: config)
    }
    
    public func clearNetworkMocks() {
        URLProtocolStub.stubUrls = [:]
    }

    private func encodeMock(object: some Encodable) -> Data {
        let jsonEncoder = JSONEncoder()
        return try! Data(jsonEncoder.encode(object))
    }
}
