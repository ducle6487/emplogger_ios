//
//  NotificationCenter.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import EmpLoggerInjection
import UserNotifications

public protocol NotificationCenter {
    func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool
    func setNotificationCategories(_ categories: Set<UNNotificationCategory>)
    func getNotificationAuthorizationStatus() async -> UNAuthorizationStatus

    var delegate: UNUserNotificationCenterDelegate? { get set }
}

extension UNUserNotificationCenter: NotificationCenter {
    func requestAuthorization() async throws -> Bool {
        try await requestAuthorization(options: [])
    }
    
    public func getNotificationAuthorizationStatus() async -> UNAuthorizationStatus {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus
    }
}

extension DependencyMap {
    private struct NotificationCenterKey: DependencyKey {
        static var dependency: any NotificationCenter = UNUserNotificationCenter.current()
    }
    
    public var notificationCenter: any NotificationCenter {
        get { resolve(key: NotificationCenterKey.self) }
        set { register(key: NotificationCenterKey.self, dependency: newValue) }
    }
}
