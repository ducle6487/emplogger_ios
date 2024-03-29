//
//  File.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerCore

protocol DataConformable {
    var data: Data { get }
    var response: URLResponse { get }
}

public struct NetworkResponse: DataConformable {
    public let data: Data
    let response: URLResponse
    var statusCode: Int?
    
    public init(data: Data, response: URLResponse, statusCode: Int? = nil) {
        self.data = data
        self.response = response
        self.statusCode = statusCode
    }
}

extension NetworkResponse: Equatable {
    public static func == (lhs: NetworkResponse, rhs: NetworkResponse) -> Bool {
        return lhs.data == rhs.data && lhs.statusCode == rhs.statusCode
    }
}

extension NetworkResponse: Loggable {
    public var literal: String {
        [
            "code": statusCode ?? 0,
            "data": String(decoding: data, as: UTF8.self),
        ]
        .literal
    }
}
