//
//  Date+toString.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension Date {
    public var displayDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM yyyy"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }

    public var shortDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
}
