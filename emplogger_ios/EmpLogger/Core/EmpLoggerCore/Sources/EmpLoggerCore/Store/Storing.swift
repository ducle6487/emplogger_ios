//
//  Storing.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import Combine
import EmpLoggerFoundation

public protocol Storing: AnyObservableObject, ObservableObject {
    func setup()
    func setupBindings()
    func cancel()
}
