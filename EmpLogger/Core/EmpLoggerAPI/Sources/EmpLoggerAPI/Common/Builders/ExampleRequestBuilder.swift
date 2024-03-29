//
//  ExampleRequestBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerInjection

public struct ExampleRequestBuilder: RequestBuilder {
    @Inject(\.exampleApiValues) var api: any ApiValues
    var relativeUrl: String
    var version: String?

    public init(relativeUrl: String, version: String? = nil) {
        self.relativeUrl = relativeUrl
        self.version = version
    }

    public func build() throws -> URLRequest {
        try RelativeRequestUrlBuilder(
            baseUrl: api.baseUrl,
            apiVersion: version,
            relativeUrl: relativeUrl
        )
        .build()
    }
}
