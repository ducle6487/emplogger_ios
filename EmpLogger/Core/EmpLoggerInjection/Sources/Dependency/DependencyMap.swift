//
//  DependencyMap.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

import SwiftUI
import Foundation

// MARK: - Key value definition

/// A generic key value type for storing a dependency inside the `DependencyMap`
///
/// The following code creates a `DependencyKey` for a new depenency:
///
///     private struct ObjectKey: DependencyKey {
///         static var dependency: any SomeObjectProtocol = Object()
///     }
///
/// A dependency key provides the initial/default value for a dependency within the `DependencyMap`
/// at compile time. This dependency can be overwritten during run time to provide subsequent concrete types
/// if the initial value does not provide the required functionality. Or if the dependency requires mocking.
///
/// Each dependency is lazily loaded on first reference through its `static` reference, thus, we do not have any
/// extra overhead on application launch for instantiating dependencies that are not immediately used. This allows us
/// to also overwrite the dependency before its first read within the application through a `WriteableKeyPath`.
///
/// - Note: Dependencies can either be stored in the key as a Concrete or Protocol type. This type will be used as the
///         resolving type at injection site. For objects that do not need to be mocked or require differing concrete
///         implementations, the use of a concrete `Value` type is preferred over an `Existential` type,
///         providing less overhead at runtime for the application, and allowing for the compiler to optimise and
///         statically dispatch the dependency.
public protocol DependencyKey {
    associatedtype Value
    static var dependency: Value { get set }
}

// MARK: - Dependency mapping

/// Dependency map reference for accessing properties through key paths
///
/// Dependency map contains a file scoped singleton reference for accessing properties.
/// All dependencies are then declared in extensions of `DependencyMap` and can be accessed
/// through Swift's `KeyPath` implementation.
///
///
/// The following code reads a property from the `DependencyMap`:
///
///     DependencyMap.map[keyPath: \.keyPathToProperty]
///
/// Accessing this property will provide both a `get` and `set` for the dependency through a `WritableKeyPath`
///
/// Declare a dynamic property within an extension of `DependencyMap` to create a dependency.
/// Creating a dependency requries a `DependencyKey` which stores the initial/default value for the dependency.
///
///
/// The following code registers a new dependency to the `DependencyMap`:
///
///     extension DependencyMap {
///
///         private struct ObjectKey: DependencyKey {
///             static var dependency: any SomeObjectProtocol = Object()
///         }
///
///         var object: any SomeObjectProtocol {
///             get { resolve(key: ObjectKey.self) }
///             set { register(key: ObjectKey.self, dependency: newValue) }
///         }
///     }
///
/// And can be accessed as follows:
///
///     // Returns the concrete implementation of Object as its existential type
///     DependencyMap.map[keyPath: \.object]
///
public class DependencyMap: DependencyLifecycleScope {
    // Ensure single thread access only to the dependency map by synchronising
    // access to a single queue
    private static let queue = DispatchQueue(label: "base.DependencyMap")
    private static var _map = DependencyMap()
    
    internal static var map: DependencyMap {
        get { queue.sync { return _map } }
        set { queue.sync { _map = newValue } }
    }
}
