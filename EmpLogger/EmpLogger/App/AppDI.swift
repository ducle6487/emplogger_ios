//
//  AppDI.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import OSLog
import EmpLoggerCore
import EmpLoggerInjection

extension EmpLoggerAppDelegate {
    func registerDI() {
        register(\.appNavigationStore, dependency: AppNavigationStore())
        register(\.analytics, dependency: RemoteAnalytics())
        register(\.deeplinking, dependency: DeeplinkInteractor())
    }
    
    func registerEnvironment() {
        #if RELEASE
        let environment = AppEnvironment.production
        #elseif STAGING
        let environment = AppEnvironment.staging
        #else
        let environment = AppEnvironment.development
        #endif
        register(\.appEnvironment, dependency: environment)
    }
}

