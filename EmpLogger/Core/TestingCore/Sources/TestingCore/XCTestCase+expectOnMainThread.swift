//
//  XCTestCase+expectOnMainThread.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import XCTest
import Combine

extension XCTestCase {
    public func expectOnMainThread(
        @_implicitSelfCapture testcase: @escaping () -> Void
    ) {
        let expectation = self.expectation(description: "Expect on main thread")

        // Run our test on a background thread as it is expected to hang
        // ensures the test will execute quickly and not wait for timeout
        DispatchQueue.main.async {
            testcase()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10) { _ in }
    }
    
    public func expectOnMainThread(
        @_implicitSelfCapture testcase: @escaping () async -> Void
    ) async {
        let expectation = self.expectation(description: "Expect on main thread")

        // Run our test on a background thread as it is expected to hang
        // ensures the test will execute quickly and not wait for timeout
        DispatchQueue.main.async {
            Task { @MainActor in
                await testcase()
                expectation.fulfill()
            }
        }
        await fulfillment(of: [expectation])
    }
}
