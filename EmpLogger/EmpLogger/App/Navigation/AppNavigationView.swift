//
//  AppNavigationView.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI
import EmpLoggerCore
import EmpLoggerInjection

struct AppNavigationView: View {
    @EnvironmentObject private var theme: ThemeProvider
    @InjectObservable(\.router) var router: Router
    @InjectObservable(\.appNavigationStore) var store
    @Inject(\.analytics) var analytics
    
    var body: some View {
        navigationTabView
    }
}

// MARK: - Tab View
extension AppNavigationView {
    
    var navigationTabView: some View {
        EmpLoggerTabView($router.tabSelectedSubject) {
            // Create our tabView's tabs from our list
            ForEach(store.tabs, id: \.id) { tab in
                // Currently selected tab should match our stored tabSelectSubject identifier
                let isSelected = $router.tabSelectedSubject.wrappedValue?.id == tab.id
                // Create our custom tab item
                EmpLoggerTabItemView(
                    icon: tab.icon,
                    selectedIcon: tab.selectedIcon,
                    isSelected: isSelected,
                    name: tab.name
                )
                .onTapGesture {
                    router.tabSelectedSubject = tab
                    analytics.log(event: tab.event)
                }
            }
        }
    }
}

// MARK: - Previews
struct AppNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
            .previewTheme(for: .light)
    }
}

