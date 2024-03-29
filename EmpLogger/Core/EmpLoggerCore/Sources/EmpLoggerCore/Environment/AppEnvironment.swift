//
//  AppEnvironment.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import EmpLoggerInjection

public enum AppEnvironment: String, Codable, CaseIterable {
    case development
    case staging
    case production
}

extension AppEnvironment {
    public var isDevelopment: Bool { self == .development }
    public var isStaging: Bool { self == .staging }
    public var isProduction: Bool { self == .production }
    
    public var displayName: String {
        switch self {
        case .development: return "Development"
        case .staging: return "Staging"
        case .production: return "Version"
        }
    }
}

extension DependencyMap {
    
    private struct AppEnvironmentKey: DependencyKey {
        static var dependency: AppEnvironment = .development
    }
    
    public var appEnvironment: AppEnvironment {
        get { resolve(key: AppEnvironmentKey.self) }
        set { register(key: AppEnvironmentKey.self, dependency: newValue) }
    }
}
