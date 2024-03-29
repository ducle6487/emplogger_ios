//
//  Calendar+dateInNext.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension Calendar {
    private var currentDate: Date { return Date() }

    public func isExpiryDateWithinOneMonth(_ date: Date) -> Bool {
        guard let nextMonth = self.date(byAdding: DateComponents(month: 1), to: currentDate) else { return false }
        return isDate(date, equalTo: nextMonth, toGranularity: .month)
            || isDate(date, equalTo: currentDate, toGranularity: .month)
    }
    
    public func isExpiryDateInPast(_ date: Date) -> Bool {
        guard let previousMonth = self.date(byAdding: DateComponents(month: -1), to: currentDate) else { return false }
        if isDate(date, equalTo: currentDate, toGranularity: .month) { return false }
        if isDate(date, equalTo: previousMonth, toGranularity: .month) { return true }
        return date < currentDate
    }
}
