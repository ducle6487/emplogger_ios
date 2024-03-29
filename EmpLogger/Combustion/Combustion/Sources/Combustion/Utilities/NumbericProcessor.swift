//
//  NumbericProcessor.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

public typealias ComparableNumeric = Numeric & Comparable

/// Simple numeric processor for base decoration
///
/// Decorator method that processes the numeric value without mutation
struct NumericProcessor<Value>: ValueProcessor {
    func process(_ value: Value) -> Value {
        value
    }
}

/// Processes the provided value by comparing it to a lower bound
///
/// After comparison, forwards the result to a the wrapped processor.
///
/// The following code declares a `LowerClamped` decorator with a lower bound:
///
///     let processor: Processor =
///         LowerClamped(
///             lowerValue: 10,
///             processor: NumericProcessor()
///         )
///
/// Calling process on this processor will execute the decoration chain:
///
///     val noLessThanTen = processor.process(20)
///     // noLessThanTen == 20
///
///     val noLessThanTen = processor.process(5)
///     // noLessThanTen == 10
///
///     val noLessThanTen = processor.process(10)
///     // noLessThanTen == 10
struct LowerClamped<Value: ComparableNumeric>: ValueProcessor {
    var lowerValue: Value
    var processor: any ValueProcessor<Value>
    func process(_ value: Value) -> Value {
        processor.process(max(value, lowerValue))
    }
}

/// Processes the provided value by comparing it to an upper bound
///
/// After comparison, forwards the result to a the wrapped processor.
///
/// The following code declares an `UpperClamped` decorator with an upper bound:
///
///     let processor: Processor =
///         UpperClamped(
///             upperValue: 50,
///             processor: NumericProcessor()
///         )
///
/// Calling process on this processor will execute the decoration chain:
///
///     val noGreaterThanFifty = processor.process(20)
///     // noLessThanTen == 20
///
///     val noGreaterThanFifty = processor.process(75)
///     // noLessThanTen == 50
///
///     val noGreaterThanFifty = processor.process(50)
///     // noLessThanTen == 50
struct UpperClamped<Value: ComparableNumeric>: ValueProcessor {
    var upperValue: Value
    var processor: any ValueProcessor<Value>
    func process(_ value: Value) -> Value {
        processor.process(min(value, upperValue))
    }
}
