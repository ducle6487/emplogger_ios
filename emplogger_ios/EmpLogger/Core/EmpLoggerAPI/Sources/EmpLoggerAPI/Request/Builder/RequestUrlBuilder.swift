//
//  RequestUrlBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public struct RequestUrlBuilder: RequestBuilder {
    var url: String
    
    public init(url: String) {
        self.url = url
    }
    
    public func build() throws -> URLRequest {
        // If our url cannot be created return a RequestError
        guard let url = URL(string: url) else { throw RequestError.invalidUrl }
        return URLRequest(url: url)
    }
}
