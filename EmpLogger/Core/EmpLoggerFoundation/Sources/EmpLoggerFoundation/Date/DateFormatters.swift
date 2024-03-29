//
//  DateFormatters.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

public enum DateFormatters {
    public static var iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZZ"
        return formatter
    }()

    public static var isoShorthandFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
