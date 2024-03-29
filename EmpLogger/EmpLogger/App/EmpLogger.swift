//
//  EmpLogger.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI
import EmpLoggerInjection

@main
struct EmpLogger: App {

    // MARK: - Injection
    @UIApplicationDelegateAdaptor(EmpLoggerAppDelegate.self) var delegate
    @StateObject var themeProvider: ThemeProvider
    @Inject(\.deeplinking) var deeplinking

    init() {
        let themeProvider = ThemeProvider(with: ColorScheme.light)
        _themeProvider = StateObject(wrappedValue: themeProvider)
    }

    var body: some Scene {
        WindowGroup {
            StatusBarHost {
                rootView
            }
            .ignoresSafeArea()
            .onOpenURL { url in
                deeplinking.deeplink(to: url.absoluteString)
            }
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                if let urlString = userActivity.webpageURL?.absoluteString {
                    deeplinking.deeplink(to: urlString)
                }
            }
        }
    }

    var rootView: some View {
        AppRootView()
            .environmentObject(themeProvider)
    }
}
