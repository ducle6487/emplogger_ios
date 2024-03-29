//
//  RequestBuilder.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerCore

public protocol RequestBuilder: ComposedLogging {
    func build() throws -> URLRequest
}
