//
//  ApiValues.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import EmpLoggerInjection

public protocol ApiValues {
    var baseUrl: URL { get }
    var version: String { get }
}
