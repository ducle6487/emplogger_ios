//
//  RemoteAnalytics.swift
//  Base
//
//  Created by AnhDuc on 06/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection
import FirebaseAnalytics

struct RemoteAnalytics: AnalyticsTracker, Logging {
    var loggerType: LoggingComponent = .analytics
    
    func log(event: String, parameters: AnalyticsEventParameters) {
        // Add our global tracking params
        let params = parameters
        Analytics.logEvent(event, parameters: params)
        log("Analytics Event: '\(event)' \nParams: '\(params)'\n")
    }
    
    func log(screen: String, parameters: AnalyticsEventParameters) {
        // create firebase log
        var params = parameters
        params["screen_name"] = screen
        Analytics.logEvent("screen_view", parameters: params)
        log("Analytics Screen View:\nParams: '\(params)'\n")
    }
}
