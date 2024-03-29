//
//  FirebaseConfig.swift
//  Base
//
//  Created by AnhDuc on 06/03/2024.
//

import Firebase
import Foundation
import EmpLoggerCore
import EmpLoggerInjection

/// Responsible for setting up Firebase Core (required for Firebase Anayltics and Firebase Remote Config)
class FirebaseConfig {
    @Inject(\.appEnvironment) static var environment
    // MARK: Type properties
    
    static let optionsUrl = {
        var resource = ""
        switch environment {
        case .development: resource = "GoogleService-Info"
        case .staging: resource = "GoogleService-Info"
        case .production: resource = "GoogleService-Info"
        }
        return Bundle.main.path(forResource: resource, ofType: ".plist")
    }()
    
    class func setup() {
        if
            let firebaseOptionsUrl = FirebaseConfig.optionsUrl,
            let firebaseOptions = FirebaseOptions(contentsOfFile: firebaseOptionsUrl)
        {
            FirebaseApp.configure(options: firebaseOptions)
            FirebaseConfiguration.shared.setLoggerLevel(.error)
        }
    }
}
