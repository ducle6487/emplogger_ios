//
//  EmployeeInteracting.swift
//
//
//  Created by AnhDuc on 29/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection

public protocol EmployeeInteracting: Interactor, DeeplinkHandler {

}

// MARK: - Dependency registration
extension DependencyMap {
    private struct EmployeeInteractorKey: DependencyKey {
        static var dependency: any EmployeeInteracting = EmployeeInteractor()
    }

    public var employeeInteractor: any EmployeeInteracting {
        get { resolve(key: EmployeeInteractorKey.self) }
        set { register(key: EmployeeInteractorKey.self, dependency: newValue) }
    }
}
