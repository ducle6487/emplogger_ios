//
//  Loggable.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

public protocol Loggable<LiteralType> {
    associatedtype LiteralType: ExpressibleByStringLiteral
    var literal: LiteralType { get }
    var sensitivity: Sensitivity { get }
}

public extension Loggable {
    /// Default sensitivity. Can be overwridden by setting sensitivity in conformance extension.
    var sensitivity: Sensitivity { .public }
    static var mask: String { "****" }
}
