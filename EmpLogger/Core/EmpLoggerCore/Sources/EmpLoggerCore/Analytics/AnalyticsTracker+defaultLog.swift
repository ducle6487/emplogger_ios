//
//  AnalyticsTracker+defaultLog.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension AnalyticsTracker {
    public func log(event: String?) {
        guard let event else { return }
        log(event: event, parameters: [:])
    }
}
