//
//  HomeInteracting.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection

public protocol HomeInteracting: Interactor, DeeplinkHandler {

}

// MARK: - Dependency registration

extension DependencyMap {
    private struct HomeInteractorKey: DependencyKey {
        static var dependency: any HomeInteracting = HomeInteractor()
    }

    public var homeInteractor: any HomeInteracting {
        get { resolve(key: HomeInteractorKey.self) }
        set { register(key: HomeInteractorKey.self, dependency: newValue) }
    }
}
