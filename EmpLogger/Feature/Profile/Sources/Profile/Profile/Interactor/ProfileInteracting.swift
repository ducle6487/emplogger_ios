//
//  ProfileInteracting.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection

public protocol ProfileInteracting: Interactor, DeeplinkHandler {

}

// MARK: - Dependency registration

extension DependencyMap {
    private struct ProfileInteractorKey: DependencyKey {
        static var dependency: any ProfileInteracting = ProfileInteractor()
    }

    public var profileInteractor: any ProfileInteracting {
        get { resolve(key: ProfileInteractorKey.self) }
        set { register(key: ProfileInteractorKey.self, dependency: newValue) }
    }
}
