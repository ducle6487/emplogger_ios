//
//  LocalAnalytics.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

/// Naive local implementation of analytics tracking through loging
/// Used as a default `AnalyticsTracker` when no remote analytics tracker
/// is implemented
struct LocalAnalytics: AnalyticsTracker, Logging {
    var loggerType: LoggingComponent = .analytics
    func log(event: String, parameters: AnalyticsEventParameters) {
        log("Tracking Analytics Event: '\(event)' with params: '\(parameters)'")
    }
    
    func log(screen: String, parameters: AnalyticsEventParameters) {
        log("Tracking Screen View with params: '\(parameters)'")
    }
}
