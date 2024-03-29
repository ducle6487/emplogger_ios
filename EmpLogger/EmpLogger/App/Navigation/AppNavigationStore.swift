//
//  AppNavigationStore.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import SwiftUI
//import Profile
import Graphics
import EmpLoggerCore
import EmpLoggerInjection

final class AppNavigationStore: Store, AppNavigationStoring {
    
//    @Inject(\.profileStore) var profileStore
    @Inject(\.router) var router
    
    /// Builds the navigation tabs using a `NavBuilder` result builder.
    @NavBuilder var tabs: [Tab] {
        Tabs.home.tab
        Tabs.employee.tab
        Tabs.news.tab
        Tabs.profile.tab
    }
    
    override func setup() {
        super.setup()
        router.tabSelectedSubject = tabs.first!
//        bindProfileChanges()
    }
    
//    private func bindProfileChanges() {
//        // when our crm profile changes trigger tab update
//        profileStore.$crmProfile.sink { profile in
//            guard profile.currentValue != nil else { return }
//            self.objectWillChange.send()
//        }
//        .store(in: &disposables)
//    }
}

