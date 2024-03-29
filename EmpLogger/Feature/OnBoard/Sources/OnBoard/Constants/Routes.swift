//
//  Routes.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore

protocol OnBoardRouterContractFactory {
    var routeToOnBoard: OnBoardView { get }
}

extension RouterContractFactory: OnBoardRouterContractFactory {
    var routeToOnBoard: OnBoardView { OnBoardView() }
}
