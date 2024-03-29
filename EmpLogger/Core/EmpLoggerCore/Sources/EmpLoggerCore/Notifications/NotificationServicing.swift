//
//  NotificationServicing.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import EmpLoggerInjection
import UserNotifications

public protocol NotificationServicing {
    func getAuthorisationStatus() async -> UNAuthorizationStatus
    func setupNotifications()
    func registerForPushNotifications() async throws -> Bool
    func updateSubscriptions(technical: Bool, marketing: Bool)
}

class EmptyNotificationService: NotificationServicing {
    func getAuthorisationStatus() async -> UNAuthorizationStatus {
        fatalError("Provide your own instance of a notification service")
    }
    
    func setupNotifications() {
        fatalError("Provide your own instance of a notification service")
    }
    
    func registerForPushNotifications() async throws -> Bool {
        fatalError("Provide your own instance of a notification service")
    }

    func updateSubscriptions(technical: Bool, marketing: Bool) {
        fatalError("Provide your own instance of a notification service")
    }
}

extension DependencyMap {
    private struct NotificationServiceKey: DependencyKey {
        static var dependency: any NotificationServicing = EmptyNotificationService()
    }
    
    public var notificationService: any NotificationServicing {
        get { resolve(key: NotificationServiceKey.self) }
        set { register(key: NotificationServiceKey.self, dependency: newValue) }
    }
}
