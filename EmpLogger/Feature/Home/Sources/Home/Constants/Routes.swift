//
//  Routes.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore

protocol HomeRouterContractFactory {
    var routeToHome: HomeView { get }
}

extension RouterContractFactory: HomeRouterContractFactory {
    public var routeToHome: HomeView { HomeView() }
}
