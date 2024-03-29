//
//  LoggingComponent.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

public enum LoggingComponent {
    case routing
    case network
    case authentication
    case store
    case interactor
    case featureFlag
    case content
    case session
    case charging
    case analytics
    case location
    case fraud
    case payment
    case error
    case remoteConfig
    case other(String)
    
    internal var enabled: Bool {
        switch self {
        case .routing: return false
        case .network: return true
        case .authentication: return false
        case .store: return false
        case .interactor: return true
        case .featureFlag: return true
        case .content: return false
        case .session: return true
        case .charging: return true
        case .analytics: return false
        case .location: return true
        case .fraud: return true
        case .payment: return true
        case .error: return true
        case .remoteConfig: return true
        case .other: return true
        }
    }
    
    public var category: String {
        switch self {
        case .other(let cat): return cat
        default: return "\(self)"
        }
    }
}

extension LoggingComponent: Hashable {}
