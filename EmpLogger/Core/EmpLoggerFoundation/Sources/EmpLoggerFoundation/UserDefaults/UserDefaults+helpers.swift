//
//  UserDefaults+helpers.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension UserDefaults {

    func save<T: UserDefaultsConformable>(_ value: T, for key: String) {
        if T.self == URL.self {
            // Handle urls as their type for storage
            self.set(value as? URL, forKey: key)
            return
        }
        
        self.set(value.storedValue, forKey: key)
    }

    func delete(for key: String) {
        self.removeObject(forKey: key)
    }

    func fetch<T: UserDefaultsConformable>(_ key: String) -> T {
        self.fetchOptional(key)!
    }

    func fetchOptional<T: UserDefaultsConformable>(_ key: String) -> T? {
        let fetched: Any?

        if T.self == URL.self {
            // Handle urls as their type for storage
            fetched = self.url(forKey: key)
        } else {
            fetched = self.object(forKey: key)
        }
        
        if fetched == nil { return nil }

        // swiftlint:disable force_cast
        return T(storedValue: fetched as! T.StoredValue)
        // swiftlint:enable force_cast
    }

    func registerDefault<T: UserDefaultsConformable>(value: T, key: String) {
        self.register(defaults: [key: value.storedValue])
    }
}

