//
//  Double+dp.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension Double {
    public func dp(_ dp: Int) -> String {
        String(format: "%.\(dp)f", self)
    }
}
