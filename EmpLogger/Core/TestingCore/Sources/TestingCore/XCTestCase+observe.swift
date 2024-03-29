//
//  XCTestCase+observe.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import XCTest
import Combine

extension XCTestCase {
    /// Adds an observation to a publisher, allowing you to track emitted values
    ///
    /// Use this method to observe a publisher and fulfill an expectation when a sequence of expected values are emitted by the publisher.
    ///
    /// - Parameters:
    ///   - publisher: The `Publisher` to observe.
    ///   - callback: An optional callback closure to expose  each emitted value to the calling site.
    ///   - expected: An array of values that are expected to be emitted by the publisher.
    ///   - cancellables: An `inout` set of `AnyCancellable` objects to which the observation will be disposed by.
    ///   - identifier: A string identifier to be used in the expectation for differntiating between calls.
    ///
    /// - Returns: An `XCTestExpectation` that will be fulfilled when the expected sequence of values is received.
    public func observe<T: Equatable>(
        _ publisher: some Publisher<T, Never>,
        @_implicitSelfCapture callback: ((T) -> Void)? = nil,
        expected: [T],
        disposedBy cancellables: inout Set<AnyCancellable>,
        identifier: String = "no-id"
    ) -> XCTestExpectation {
        let exp = expectation(description: "\(identifier):\(publisher) to receive \(expected)")
        var values = [T]()
        publisher.sink { value in
            values.append(value)
            callback?(value)
            print("\(identifier) has received: \(values)\nExpected: \(expected)")
            if values == expected {
                exp.fulfill()
            }
        }
        .store(in: &cancellables)
        return exp
    }
    
    /// Adds an observation to a publisher, allowing you to track emitted values
    ///
    /// Use this method to observe a publisher and fulfill an expectation when a sequence of expected values are emitted by the publisher.
    /// Optional types that conform to `Equatable` also work for expectations.
    ///
    /// - Parameters:
    ///   - publisher: The `Publisher` to observe.
    ///   - callback: An optional callback closure to expose  each emitted value to the calling site.
    ///   - expected: An array of values that are expected to be emitted by the publisher.
    ///   - cancellables: An `inout` set of `AnyCancellable` objects to which the observation will be disposed by.
    ///   - identifier: A string identifier to be used in the expectation for differntiating between calls.
    ///
    /// - Returns: An `XCTestExpectation` that will be fulfilled when the expected sequence of values is received.
    public func observe<T: Equatable>(
        _ publisher: some Publisher<T?, Never>,
        @_implicitSelfCapture callback: ((T?) -> Void)? = nil,
        expected: [T?],
        disposedBy cancellables: inout Set<AnyCancellable>,
        identifier: String = "no-id"
    ) -> XCTestExpectation {
        let exp = expectation(description: "\(identifier):\(publisher) to receive \(expected)")
        var values = [Optional<T>]()
        publisher.sink { value in
            values.append(value)
            callback?(value)
            print("\(identifier) has received: \(values)\nExpected: \(expected)")
            if values == expected {
                exp.fulfill()
            }
        }
        .store(in: &cancellables)
        return exp
    }
    
    /// Adds an observation to a publisher, allowing you to track if a subset of values was emitted
    ///
    /// Use this method to observe a publisher and fulfill an expectation when a sequence of expected values are emitted by the publisher,
    /// but the publisher can emit other values in another order. This will check if the expected values are emitted contiguously.
    ///
    /// - Parameters:
    ///   - publisher: The `Publisher` to observe.
    ///   - callback: An optional callback closure to expose  each emitted value to the calling site.
    ///   - contains: An array of values that are expected to be emitted by the publisher.
    ///   - cancellables: An `inout` set of `AnyCancellable` objects to which the observation will be disposed by.
    ///   - identifier: A string identifier to be used in the expectation for differntiating between calls.
    ///
    /// - Returns: An `XCTestExpectation` that will be fulfilled when the expected sequence of values is received.
    public func observe<T: Equatable>(
        _ publisher: some Publisher<T, Never>,
        @_implicitSelfCapture callback: ((T) -> Void)? = nil,
        contains: [T],
        disposedBy cancellables: inout Set<AnyCancellable>,
        identifier: String = "no-id"
    ) -> XCTestExpectation {
        let exp = expectation(description: "\(identifier):\(publisher) to receive \(contains)")
        var values = [T]()
        publisher.sink { value in
            values.append(value)
            callback?(value)
            print("\(identifier) has received: \(values)\nExpected: \(contains)")
            if #available(iOS 16.0, *) {
                if values.contains(contains) {
                    exp.fulfill()
                }
            }
        }
        .store(in: &cancellables)
        return exp
    }
    
    /// Adds an observation to a publisher, allowing you to track emitted values
    ///
    /// Use this method to observe a publisher and determine fulfillment of an expectation based on a provided 'expect' closure parameter.
    ///
    /// - Parameters:
    ///   - publisher: The `Publisher` to observe.
    ///   - expect: A closure that accepts an emitted value from the `Publisher` & returns a `Bool`
    ///   - cancellables: An `inout` set of `AnyCancellable` objects to which the observation will be disposed by.
    ///   - identifier: A string identifier to be used in the expectation for differntiating between calls.
    ///
    /// - Returns: An `XCTestExpectation` that will be fulfilled when the expected sequence of values is received.
    public func observe<T: Equatable>(
        _ publisher: some Publisher<T, Never>,
        @_implicitSelfCapture expect: @escaping (T) -> Bool,
        disposedBy cancellables: inout Set<AnyCancellable>,
        identifier: String = "no-id"
    ) -> XCTestExpectation {
        let exp = expectation(description: "\(identifier): to meet custom expectation")
        publisher.sink { value in
            print("\(identifier) has received: \(value)")
            if expect(value) { exp.fulfill() }
        }
        .store(in: &cancellables)
        return exp
    }
    
    public func observe<T: Equatable>(
        _ publisher: some Publisher<T?, Never>,
        @_implicitSelfCapture expect: @escaping (T) -> Bool,
        disposedBy cancellables: inout Set<AnyCancellable>,
        identifier: String = "no-id"
    ) -> XCTestExpectation {
        let exp = expectation(description: "\(identifier): to meet custom expectation")
        publisher.sink { value in
            guard let value else { return }
            print("\(identifier) has received: \(value)")
            if expect(value) { exp.fulfill() }
        }
        .store(in: &cancellables)
        return exp
    }
}
