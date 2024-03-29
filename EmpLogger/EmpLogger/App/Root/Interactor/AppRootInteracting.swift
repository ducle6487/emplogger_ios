//
//  AppRootInteracting.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection

protocol AppRootInteracting: Interactor {
    func closeCarouselOverlay()
}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct AppRootInteractorKey: DependencyKey {
        static var dependency: any AppRootInteracting = AppRootInteractor()
    }
    
    var appRootInteractor: any AppRootInteracting {
        get { resolve(key: AppRootInteractorKey.self) }
        set { register(key: AppRootInteractorKey.self, dependency: newValue) }
    }
}

