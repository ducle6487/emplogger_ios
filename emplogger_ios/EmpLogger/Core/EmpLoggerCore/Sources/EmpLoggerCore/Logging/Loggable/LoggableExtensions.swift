//
//  LoggableExtensions.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension String: Loggable {
    public var literal: String { self.sensitivity == .public ? self : Self.mask }
}

extension Int: Loggable {
    public var literal: String { self.sensitivity == .public ? "\(self)" : Self.mask }
}

extension Array: Loggable where Element: Loggable {
    public var literal: String {
        self.map { $0.sensitivity == .public ? "\($0)" : Self.mask }.joined(separator: " ")
    }
}

extension Encodable {
    public var literal: String {
        guard let encoded = try? JSONEncoder().encode(self) else { return "EncodingError" }
        return String(decoding: encoded, as: UTF8.self)
    }
}

extension Dictionary: Loggable {
    public var literal: String {
        let keyValuePair = self.map { "\"\($0.key)\":\"\($0.value)\"" }
        return "{\(keyValuePair.joined(separator: ","))}"
    }
}

extension URLRequest: Loggable {
    public var literal: String {
        [
            "url": url?.absoluteString ?? "none-set",
            "method": httpMethod ?? "none-set",
            "body": String(decoding: httpBody ?? Data(), as: UTF8.self),
        ]
        .literal
    }
}
