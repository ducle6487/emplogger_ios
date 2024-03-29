//
//  File.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public struct RelativeRequestUrlBuilder: RequestBuilder {
    var baseUrl: URL
    var apiVersion: String?
    var relativeUrl: String
    
    public init(baseUrl: URL, apiVersion: String? = nil, relativeUrl: String) {
        self.baseUrl = baseUrl
        self.apiVersion = apiVersion
        self.relativeUrl = relativeUrl
        if let apiVersion {
            self.relativeUrl = apiVersion + "/" + relativeUrl
        }
    }
    
    public func build() throws -> URLRequest {
        // If our url cannot be created return a RequestError
        guard let url = URL(string: relativeUrl, relativeTo: baseUrl) else {
            throw RequestError.invalidUrl
        }

        return URLRequest(url: url)
    }
}
