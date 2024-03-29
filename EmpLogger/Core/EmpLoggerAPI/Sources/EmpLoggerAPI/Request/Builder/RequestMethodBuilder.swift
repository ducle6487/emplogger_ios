//
//  RequestMethodBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public struct RequestMethodBuilder: RequestBuilder {
    var method: HttpMethod
    var builder: RequestBuilder
    
    public init(method: HttpMethod, builder: RequestBuilder) {
        self.method = method
        self.builder = builder
    }
    
    public func build() throws -> URLRequest {
        var request = try builder.build()
        request.httpMethod = method.rawValue
        request.httpBody = method.body
        return request
    }
}
