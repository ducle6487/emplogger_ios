//
//  UserDefault.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation
import Combine

@propertyWrapper
public struct UserDefault<Value: UserDefaultsConformable> {
    public let key: String
    private let userDefaults: UserDefaults
    private let defaultValue: Value
    private var storedValue: Value {
        get { userDefaults.fetch(key) }
        set { userDefaults.save(newValue, for: key) }
    }
    
    public init(
        keyName: any UserDefaultKey,
        defaultValue: Value,
        userDefaults: UserDefaults = .standard
    ) {
        // Register default
        userDefaults.registerDefault(value: defaultValue, key: keyName.key)
        
        self.key = keyName.key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    /// Subscript for accessing the enclosing self
    ///
    /// Used for accessing the enclosed ObservableObject and unwrapping its objectWillChange publisher,
    /// triggering the send() event on update of the user default, in turn triggering a view update.
    ///
    /// This is an alternative way of accessing a property wrapper instance as documented in the Swift evolution
    /// proposal for propertyWrappers.
    public static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance instance: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            instance[keyPath: storageKeyPath].storedValue
        }
        set {
            // Unwrap our enclosing self's object will change to an Observable publisher
            // and notify of change
            if let publisher = instance.objectWillChange as? ObservableObjectPublisher {
                Task { @MainActor in publisher.send() }
            }
            // Update our value
            instance[keyPath: storageKeyPath].storedValue = newValue
        }
    }
    
    @available(*, unavailable, message: "@UserDefault can only be applied to properties of classes")
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
}

