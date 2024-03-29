//
//  UserDefaultsConformable.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

/// Describes a value that can be saved to and fetched from `UserDefaults`.
///
/// Default conformances are provided for:
///    - `Bool`
///    - `Int`
///    - `UInt`
///    - `Float`
///    - `Double`
///    - `String`
///    - `URL`
///    - `Date`
///    - `Data`
///    - `Array`
///    - `Set`
///    - `Dictionary`
///    - `RawRepresentable`
public protocol UserDefaultsConformable {

    /// The type of the value that is stored in `UserDefaults`.
    associatedtype StoredValue

    /// The value to store in `UserDefaults`.
    var storedValue: StoredValue { get }

    /// Initializes the object using the provided value.
    ///
    /// - Parameter storedValue: The previously store value fetched from `UserDefaults`.
    init(storedValue: StoredValue)
}

extension Bool: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Int: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension UInt: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Float: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Double: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension String: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension URL: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Date: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Data: UserDefaultsConformable {
    public var storedValue: Self { self }

    public init(storedValue: Self) {
        self = storedValue
    }
}

extension Array: UserDefaultsConformable where Element: UserDefaultsConformable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = storedValue.map { Element(storedValue: $0) }
    }
}

extension Set: UserDefaultsConformable where Element: UserDefaultsConformable {
    public var storedValue: [Element.StoredValue] {
        self.map { $0.storedValue }
    }

    public init(storedValue: [Element.StoredValue]) {
        self = Set(storedValue.map { Element(storedValue: $0) })
    }
}

extension Dictionary: UserDefaultsConformable where Key == String, Value: UserDefaultsConformable {
    public var storedValue: [String: Value.StoredValue] {
        self.mapValues { $0.storedValue }
    }

    public init(storedValue: [String: Value.StoredValue]) {
        self = storedValue.mapValues { Value(storedValue: $0) }
    }
}

extension UserDefaultsConformable where Self: RawRepresentable, Self.RawValue: UserDefaultsConformable {
    public var storedValue: RawValue.StoredValue { self.rawValue.storedValue }

    public init(storedValue: RawValue.StoredValue) {
        self = Self(rawValue: Self.RawValue(storedValue: storedValue))!
    }
}

