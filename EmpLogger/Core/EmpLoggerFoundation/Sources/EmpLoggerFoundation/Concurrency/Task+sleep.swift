//
//  Task+sleep.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    public static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }

    public static func sleep(until interval: TimeInterval) async throws {
        guard interval.seconds > 0 else { return }
        let duration = UInt64(interval.seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
