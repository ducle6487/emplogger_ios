//
//  HttpMethod.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public enum HttpMethod {
    case get
    case post(body: Data?)
    case put(body: Data?)
    case delete

    public var rawValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }

    public var body: Data? {
        switch self {
        case .get, .delete:
            return nil
        case let .post(body), let .put(body):
            return body
        }
    }
}
