//
//  EnabledComponentLogger.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

public struct EnabledComponentLogger: Logger {
    var logger: any Logger
    
    public init(logger: any Logger) {
        self.logger = logger
    }
    
    public func log(_ message: any Loggable, _ component: LoggingComponent, _ level: Severity) {
        if component.enabled || level.alwaysLog {
            logger.log(message, component, level)
        }
    }
}
