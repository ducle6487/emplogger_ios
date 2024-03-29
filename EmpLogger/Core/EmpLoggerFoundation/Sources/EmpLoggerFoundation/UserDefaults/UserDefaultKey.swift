//
//  UserDefaultKey.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

public protocol UserDefaultKey {
    var key: String { get }
}

extension String: UserDefaultKey {
    public var key: String { self }
}

