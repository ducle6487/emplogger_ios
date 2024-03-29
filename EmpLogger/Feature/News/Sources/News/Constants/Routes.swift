//
//  Routes.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore

protocol NewsRouterContractFactory {
    var routeToNews: NewsView { get }
}

extension RouterContractFactory: NewsRouterContractFactory {
    public var routeToNews: NewsView { NewsView() }
}
