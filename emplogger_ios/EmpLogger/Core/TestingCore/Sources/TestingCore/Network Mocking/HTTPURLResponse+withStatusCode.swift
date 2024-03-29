//
//  HTTPURLResponse+withStatusCode.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

extension HTTPURLResponse {
    public static func with(statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "test")!, statusCode: statusCode, httpVersion: "1", headerFields: [:])!
    }
}
