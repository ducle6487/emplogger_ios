//
//  RouterContractFactory.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import EmpLoggerInjection

public final class RouterContractFactory {}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct RouterContractFactoryKey: DependencyKey {
        static var dependency: RouterContractFactory = RouterContractFactory()
    }
    
    public var contractFactory: RouterContractFactory {
        get { resolve(key: RouterContractFactoryKey.self) }
        set { register(key: RouterContractFactoryKey.self, dependency: newValue) }
    }
}
