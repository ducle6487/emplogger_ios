//
//  RequestQueryBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public struct RequestQueryBuilder: RequestBuilder {
    var queryItems: [URLQueryItem]
    var builder: RequestBuilder
    
    public init(queryItems: [URLQueryItem], builder: RequestBuilder) {
        self.queryItems = queryItems
        self.builder = builder
    }
    
    public func build() throws -> URLRequest {
        var request = try builder.build()
        
        // Retrieve our url and add our query params.
        // If no url was found in the request then skip over and
        // return the previous builders request as it may already be handled
        if let url = request.url {
            log("Setting query params for request:", queryItems.map { "\($0.name): \($0.value ?? "none")" }, component: .network)
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            request.url  = components?.url
        }
        
        return request
    }
}
