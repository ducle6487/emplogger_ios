//
//  Routes.swift
//
//
//  Created by AnhDuc on 28/03/2024.
//

import EmpLoggerCore

protocol EmployeeRouterContractFactory {
    var routeToEmployee: EmployeeView { get }
}

extension RouterContractFactory: EmployeeRouterContractFactory {
    public var routeToEmployee: EmployeeView { EmployeeView() }
}
