//
//  InjectNonObservablePreconditionPropertyWrapperTest.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

import XCTest
import Combine
import SwiftUI
import EmpLoggerFoundation
@testable import EmpLoggerInjection

final class InjectNonObservablePreconditionPropertyWrapperTest: XCTestCase, DependencyRegistrant, DependencyMocker {
    private var disposables = Set<AnyCancellable>()
    
    // MARK: - Mock objects
    
    // Wrapper class for delaying our injection because injection happens on instantation of object
    class WrapperClass {
        @InjectObservable(\.testObject) var testNonObservableObject: any SomeTestProtocol
    }
    
    // MARK: - Lifecycle
    override func setUp() async throws {
        // Setup our test response and serialise to data
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    // MARK: - Precondition
    func testPreconditionTriggersOnNonObservableObject() {
        expectingPreconditionFailure("Cannot observe an object that does not confrom to 'AnyObservableObject'") {
            // Create our wrapper class to trigger injection of object not conforming to observable object
            _ = WrapperClass()
        }
    }
}
