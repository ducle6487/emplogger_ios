//
//  DeeplinkingConfig.swift
//  Base
//
//  Created by AnhDuc on 06/03/2024.
//

import Foundation
import EmpLoggerInjection

public protocol DeeplinkingConfig {
    var appPortalUrl: String { get }
}

struct DevDeeplinkingConfig: DeeplinkingConfig {
    var appPortalUrl: String = "https://google.com"
}

struct StgDeeplinkingConfig: DeeplinkingConfig {
    var appPortalUrl: String = "https://google.com"
}

struct ProdDeeplinkingConfig: DeeplinkingConfig {
    var appPortalUrl: String = "https://google.com"
}

extension DependencyMap {
    private struct DeeplinkingConfigKey: DependencyKey {
        @Inject(\.appEnvironment) static var environment

        static var dependency: any DeeplinkingConfig = {
            switch environment {
            case .development: return DevDeeplinkingConfig()
            case .staging: return StgDeeplinkingConfig()
            case .production: return ProdDeeplinkingConfig()
            }
        }()
    }
    
    var deeplinkingConfig: any DeeplinkingConfig {
        get { resolve(key: DeeplinkingConfigKey.self )}
        set { register(key: DeeplinkingConfigKey.self, dependency: newValue) }
    }
    
}
