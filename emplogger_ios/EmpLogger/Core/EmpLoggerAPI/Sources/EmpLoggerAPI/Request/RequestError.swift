//
//  RequestError.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public enum RequestError: Error {
    case invalidUrl
}

extension RequestError: Equatable {
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, invalidUrl):
            return true
        }
    }
}
