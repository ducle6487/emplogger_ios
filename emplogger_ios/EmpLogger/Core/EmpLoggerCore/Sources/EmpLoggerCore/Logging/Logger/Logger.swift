//
//  Logger.swift
//  
//
//  Created by AnhDuc on 04/03/2024.
//

import OSLog
import EmpLoggerInjection

public protocol Logger {
    func log(_ message: any Loggable, _ component: LoggingComponent, _ level: Severity)
}

extension Logger {
    // Forward default logs
    func log(_ message: any Loggable, _ component: LoggingComponent) {
        log(message, component, .verbose)
    }
}

// MARK: - Dependency registration

extension DependencyMap {
    private struct LoggableKey: DependencyKey {
        static var dependency: any Logger = EnabledComponentLogger(logger: OSLogger())
    }
    
    public var logger: any Logger {
        get { resolve(key: LoggableKey.self) }
        set { register(key: LoggableKey.self, dependency: newValue) }
    }
}
