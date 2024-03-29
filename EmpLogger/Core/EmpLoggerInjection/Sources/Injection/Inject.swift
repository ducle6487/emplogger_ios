//
//  Inject.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

@propertyWrapper
public struct Inject<Dependency>: DependencyLifecycleScope {
    private let keyPath: WritableKeyPath<DependencyMap, Dependency>
    public var wrappedValue: Dependency {
        get { resolve(keyPath) }
        set { register(keyPath, dependency: newValue) }
    }
    public init(_ keyPath: WritableKeyPath<DependencyMap, Dependency>) {
        self.keyPath = keyPath
    }
}
