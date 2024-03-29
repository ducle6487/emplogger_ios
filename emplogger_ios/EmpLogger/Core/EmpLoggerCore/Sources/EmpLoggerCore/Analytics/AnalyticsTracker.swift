//
//  AnalyticsTracker.swift
//  
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation
import EmpLoggerInjection

public typealias AnalyticsEventParameters = [String: Any]
public protocol AnalyticsTracker {
    var dateFormatter: DateFormatter {get}
    func log(event: String, parameters: AnalyticsEventParameters)
    func log(screen: String, parameters: AnalyticsEventParameters)
}

public extension AnalyticsTracker {
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return df
    }
}

extension DependencyMap {
    private struct LoggableKey: DependencyKey {
        static var dependency: any AnalyticsTracker = LocalAnalytics()
    }
    
    public var analytics: any AnalyticsTracker {
        get { resolve(key: LoggableKey.self) }
        set { register(key: LoggableKey.self, dependency: newValue) }
    }
}
