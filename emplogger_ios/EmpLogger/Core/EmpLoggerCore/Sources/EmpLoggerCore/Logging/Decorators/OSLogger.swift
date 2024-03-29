//
//  OSLogger.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import OSLog
import Foundation
import EmpLoggerInjection

public final class OSLogger: Logger {
    private var loggers: [LoggingComponent: os.Logger] = [:]
    public init() {}
    
    public func log(_ message: any Loggable, _ component: LoggingComponent, _ level: Severity) {
        Task {
            await createLoggerIfNeeded(with: component)
            let literal = "\(message.literal)"
            loggers[component]?.log(level: level.osLevel, "\(literal, privacy: .auto)")
        }
    }
    
    @MainActor
    private func createLoggerIfNeeded(with component: LoggingComponent) {
        guard loggers[component] == nil else { return }
        let subsystem = Bundle.main.bundleIdentifier ?? ""
        let logger = os.Logger(subsystem: subsystem, category: component.category)
        loggers[component] = logger
    }
}
