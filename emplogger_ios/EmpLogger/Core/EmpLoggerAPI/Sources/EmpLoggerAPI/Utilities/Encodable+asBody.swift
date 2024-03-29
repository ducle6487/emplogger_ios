//
//  Encodable+asBody.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

extension Encodable {
    public func asBody() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}

