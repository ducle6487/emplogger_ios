//
//  Tabs.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import Home
import Profile
import Employee
import News
import SwiftUI
import Graphics
import EmpLoggerCore
import EmpLoggerInjection

enum Tabs: String, Identifiable {
    case home
    case employee
    case news
    case profile

    var id: String { self.rawValue }
    var name: String {
        switch self {
        case .home: return "Home"
        case .employee: return "Employee"
        case .news: return "News"
        case .profile: return "Profile"
        }
    }

    var tab: Tab {
        switch self {
        case .home:
            return Tab(
                id: id,
                icon: Icons.Tabs.home,
                selectedIcon: Icons.Tabs.homeSelected,
                name: name,
                event: Event.Button.Tabs.tapNavHome,
                destination: contract.routeToHome,
                deeplinkHandler: DependencyMap.resolve(\.homeInteractor)
            )
        case .employee:
            return Tab(
                id: id,
                icon: Icons.Tabs.home,
                selectedIcon: Icons.Tabs.homeSelected,
                name: name,
                event: Event.Button.Tabs.tapNavEmployee,
                destination: contract.routeToEmployee,
                deeplinkHandler: DependencyMap.resolve(\.employeeInteractor)
            )
        case .news:
            return Tab(
                id: id,
                icon: Icons.Tabs.home,
                selectedIcon: Icons.Tabs.homeSelected,
                name: name,
                event: Event.Button.Tabs.tapNavNews,
                destination: contract.routeToNews,
                deeplinkHandler: DependencyMap.resolve(\.newsInteractor)
            )
        case .profile:
            return Tab(
                id: id,
                icon: Icons.Tabs.home,
                selectedIcon: Icons.Tabs.homeSelected,
                name: name,
                event: Event.Button.Tabs.tapNavProfile,
                destination: contract.routeToProfile,
                deeplinkHandler: DependencyMap.resolve(\.profileInteractor)
            )
        }
    }

    private var contract: RouterContractFactory {
        DependencyMap.resolve(\.contractFactory)
    }
}
