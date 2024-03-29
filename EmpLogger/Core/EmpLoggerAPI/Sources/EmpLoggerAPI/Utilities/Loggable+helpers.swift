//
//  Loggable+helpers.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import EmpLoggerCore

public extension Error {
    var loggable: any Loggable {
        if let error = self as? ApiError { return error }
        return self.localizedDescription
    }
}
