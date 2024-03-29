//
//  View+analyticsScreen.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion
import EmpLoggerCore
import EmpLoggerInjection
import EmpLoggerFoundation

struct AnalyticsScreenModifier: ViewModifier {
    @EnvironmentObject var theme: ThemeProvider
    @Inject(\.analytics) var analytics
    
    var screenName: String
    var screenClass: String = "View"
    var extras: [String: Any]
    private var scopedExtras: [String: Any] {
        [
            "theme": theme.isDarkMode ? "darkMode" : "lightMode",
            "screen_class": screenClass,
        ]
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                // Log the screen appearing with extra information about the screen
                analytics.log(
                    screen: screenName,
                    parameters: extras.merging(scopedExtras, uniquingKeysWith: MergingStrategy.keepOld)
                )
            }
    }
}

extension View {
    public func analytics(screen: String, extras: [String: Any] = [:]) -> some View {
       modifier(AnalyticsScreenModifier(screenName: screen, extras: extras))
    }
}
