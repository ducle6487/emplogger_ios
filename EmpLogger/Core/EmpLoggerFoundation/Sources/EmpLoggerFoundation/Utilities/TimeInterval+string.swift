//
//  TimeInterval+string.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension TimeInterval {
    public var displayTimeAsString: String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
