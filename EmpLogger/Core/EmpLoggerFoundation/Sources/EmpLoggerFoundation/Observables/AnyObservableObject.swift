//
//  AnyObservableObject.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

import Combine

public protocol AnyObservableObject: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}
