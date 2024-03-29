//
//  AppRootRoutingContract.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import EmpLoggerCore

protocol AppRootRoutingContract {
    var routeToNavigationRoot: AppNavigationView { get }
}

extension RouterContractFactory: AppRootRoutingContract {
    var routeToNavigationRoot: AppNavigationView {
        AppNavigationView()
    }
}

