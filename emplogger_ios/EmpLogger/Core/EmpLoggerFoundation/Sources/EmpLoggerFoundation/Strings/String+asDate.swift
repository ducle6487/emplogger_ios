//
//  String+asDate.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

public extension String {
    var asDate: Date? {
        return DateFormatters.iso8601Formatter.date(from: self)
    }
}
