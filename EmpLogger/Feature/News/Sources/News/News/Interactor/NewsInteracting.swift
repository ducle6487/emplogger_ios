//
//  NewsInteracting.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection

public protocol NewsInteracting: Interacting, DeeplinkHandler {

}

// MARK: - Dependency registration
extension DependencyMap {
    private struct NewsInteractorKey: DependencyKey {
        static var dependency: any NewsInteracting = NewsInteractor()
    }

    public var newsInteractor: any NewsInteracting {
        get { resolve(key: NewsInteractorKey.self) }
        set { register(key: NewsInteractorKey.self, dependency: newValue) }
    }
}
