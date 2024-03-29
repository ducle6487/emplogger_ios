//
//  EmpLoggerAppDelegate.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import UIKit
import EmpLoggerCore
import EmpLoggerInjection

class EmpLoggerAppDelegate: NSObject, UIApplicationDelegate, DependencyRegistrant, Logging {
    var loggerType: LoggingComponent = .other("appDelegate")

    @Inject(\.appEnvironment) var environment

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        registerEnvironment()
        FirebaseConfig.setup()
        registerDI()
        
        return true
    }

}

