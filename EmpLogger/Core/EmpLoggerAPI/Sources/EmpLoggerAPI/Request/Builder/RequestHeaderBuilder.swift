//
//  RequestHeaderBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerFoundation

public struct RequestHeaderBuilder: RequestBuilder {
    var headers: [String: String]
    var builder: RequestBuilder
    
    public init(
        headers: [String: String],
        builder: RequestBuilder
    ) {
        // Merge our defaults with the new headers and overwrite any defaults with the new values
        self.headers = Headers.default.merging(headers, uniquingKeysWith: MergingStrategy.overwrite)
        self.builder = builder
    }
    
    public func build() throws -> URLRequest {
        var request = try builder.build()
        // Add all our headers
        headers.forEach { header in
            log("Setting request header:", header.key, ":", header.value, component: .network)
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
}
