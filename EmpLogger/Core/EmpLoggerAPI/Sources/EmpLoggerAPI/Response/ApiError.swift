//
//  ApiError.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerCore

public enum ApiError: Error {
    case connection
    case conflict
    case parsing
    case denied
    case notFound
    case unauthorized
    case timeout
    case other(error: Error)
    case server(statusCode: Int, payload: Data?)
    case message(message: String, statusCode: Int)
    case errorMessage(message: ApiMessageError, statusCode: Int)
}

extension ApiError: Equatable {
    public static func == (lhs: ApiError, rhs: ApiError) -> Bool {
        switch (lhs, rhs) {
        case (let .server(lhsStatusCode, lhsPayload), let .server(rhsStatusCode, rhsPayload)):
            return lhsStatusCode == rhsStatusCode && lhsPayload == rhsPayload
        case (let .message(lhsMessage, lhsStatusCode), let .message(rhsMessage, rhsStatusCode)):
            return lhsMessage == rhsMessage && lhsStatusCode == rhsStatusCode
        case (let .errorMessage(lhsMessage, lhsStatusCode), let .errorMessage(rhsMessage, rhsStatusCode)):
            return lhsMessage.code == rhsMessage.code && lhsStatusCode == rhsStatusCode
        case (let .other(lErr), let .other(rErr)):
            return lErr.localizedDescription == rErr.localizedDescription
        case (.connection, .connection),
            (.conflict, .conflict),
            (.notFound, .notFound),
            (.parsing, .parsing),
            (.denied, .denied),
            (.unauthorized, .unauthorized),
            (.timeout, .timeout):
            return true
        default:
            return false
        }
    }
}

public struct ApiMessageError: Codable {
    public var code: Int?
    public var reason: String?
    public var message: String?
    public var displayMessage: String?
    public var underlyingErrors: String?
    public var canRetry: Bool?
    
    public init(
        code: Int? = nil,
        reason: String? = nil,
        message: String? = nil,
        displayMessage: String? = nil,
        underlyingErrors: String? = nil,
        canRetry: Bool? = false
    ) {
        self.code = code
        self.reason = reason
        self.message = message
        self.displayMessage = displayMessage
        self.underlyingErrors = underlyingErrors
        self.canRetry = canRetry
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.reason = try container.decodeIfPresent(String.self, forKey: .reason)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.displayMessage = try container.decodeIfPresent(String.self, forKey: .displayMessage)
        self.underlyingErrors = try container.decodeIfPresent(String.self, forKey: .underlyingErrors)
        self.canRetry = try container.decodeIfPresent(Bool.self, forKey: .canRetry)
        
        // Assert that struct is not empty
        // Some values can be nil but never all
        guard code != nil ||
            reason != nil ||
            message != nil ||
            displayMessage != nil ||
            underlyingErrors != nil ||
            canRetry != nil
        else {
            let context = DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "ApiMessageError must have at least 1 non-nil value"
            )
            throw DecodingError.valueNotFound(ApiMessageError.self, context)
        }
    }
}

// MARK: - Loggable implementation
extension ApiError: Loggable {
    // handle custom loggable conversion for sending more meaningful representation of an api error
    public var literal: String {
        switch self {
        case .other(error: let error): return "ApiError.other: \(error.loggable)"
        case .server(statusCode: let code, payload: let data): return "ApiError.server: \(code), \(data?.debugDescription ?? "")"
        case .message(message: let message, statusCode: let code): return "ApiError.message: \(code), \(message)"
        case .errorMessage(message: let message, statusCode: let code): return "ApiError.errorMessage: \(code), \(message)"
        default: return "\(self)"
        }
    }
}
