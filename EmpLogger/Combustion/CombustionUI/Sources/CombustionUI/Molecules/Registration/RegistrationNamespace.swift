//
//  RegistrationNamespace.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

private struct RegistrationNamespaceKey: EnvironmentKey {
    static var defaultValue: Namespace.ID?
}

extension EnvironmentValues {
    public var registrationNamespace: Namespace.ID? {
        get { self[RegistrationNamespaceKey.self] }
        set { self[RegistrationNamespaceKey.self] = newValue }
    }
}
