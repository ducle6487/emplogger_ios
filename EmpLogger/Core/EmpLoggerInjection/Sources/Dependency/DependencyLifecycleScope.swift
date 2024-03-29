//
//  DependencyLifecycleScope.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

// Compose our protocols together for all functionality whilst still separating concerns
public protocol DependencyLifecycleScope: DependencyResolver, DependencyRegistrant {}
public protocol DependencyRegistrant {}
public protocol DependencyResolver {}

extension DependencyRegistrant {
    /// Register a dependency by keyPath
    ///
    /// Forwards dependency registration to the `DependencyMap`
    public func register<Dependency>(_ keyPath: WritableKeyPath<DependencyMap, Dependency>, dependency: Dependency) {
        DependencyMap.map[keyPath: keyPath] = dependency
    }
    
    /// Register a dependency by key
    ///
    /// Forwards dependency registration via dependency key to the `DependencyMap`
    public func register<Key>(key: Key.Type, dependency: Key.Value) where Key: DependencyKey {
        key.dependency = dependency
    }
}

extension DependencyResolver {
    /// Resolve a dependency
    ///
    /// Forwards dependency resolution to the `DependencyMap`
    public func resolve<Dependency>(_ keyPath: WritableKeyPath<DependencyMap, Dependency>) -> Dependency {
        Self.resolve(keyPath)
    }
    
    /// Resolution outside of self scope or inside initializers
    ///
    /// Forwards dependency resolution to the `DependencyMap`
    public static func resolve<Dependency>(_ keyPath: WritableKeyPath<DependencyMap, Dependency>) -> Dependency {
        return DependencyMap.map[keyPath: keyPath]
    }
    
    /// Register a dependency by key
    ///
    /// Forwards dependency registration via dependency key to the `DependencyMap`
    public func resolve<Key>(key: Key.Type) -> Key.Value where Key: DependencyKey {
        return key.dependency
    }
}

