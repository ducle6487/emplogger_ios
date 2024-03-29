//
//  Constants.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore

protocol ProfileRouterContractFactory {
    var routeToProfile: ProfileView { get }
}

extension RouterContractFactory: ProfileRouterContractFactory {
    public var routeToProfile: ProfileView { ProfileView() }
}
