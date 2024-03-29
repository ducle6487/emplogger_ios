//
//  Clamping.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

/// Clamps the wrapped value to be a numeric >= .zero
///
/// Wraps a property and will replace the set value with zero if the `newValue` is
/// greater than zero. You can use `PositiveClamped` to ensure a property's value
/// will always be positive or zero.
///
/// The following code declares a property and clamps its value to >= .zero:
///
///     struct PositiveProperty {
///         @PositiveClamped var positiveNumber = 10
///     }
///
/// Updating this property at any time, will run the `UpperClamped` `NumericProcessor`,
/// on set of `newValue` yielding the following results:
///
///     positiveNumber = -20
///     // positiveNumber == 0
///
///     positiveNumber = 25
///     // positiveNumber == 25
///
///     positiveNumber = 0
///     // positiveNumber == 0
@propertyWrapper
public struct PositiveClamped<Value: ComparableNumeric> {
    private var value: Value
    public var wrappedValue: Value {
        get { value }
        set {
            value = LowerClamped(
                lowerValue: .zero,
                processor: NumericProcessor()
            ).process(newValue)
        }
    }
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}

/// Clamps the wrapped value to be a numeric <= .zero
///
/// Wraps a property and will replace the set value with zero if the `newValue` is
/// greater than zero. You can use `NegativeClamped` to ensure a property's value
/// will always be negative or zero.
///
/// The following code declares a property and clamps its value to <= .zero:
///
///     struct NegativeProperty {
///         @NegativeClamped var negativeNumber = -10
///     }
///
/// Updating this property at any time, will run the `UpperClamped` `NumericProcessor`,
/// on set of `newValue` yielding the following results:
///
///     negativeNumber = 20
///     // negativeNumber == 0
///
///     negativeNumber = -25
///     // negativeNumber == -25
///
///     negativeNumber = 0
///     // negativeNumber == 0
@propertyWrapper
public struct NegativeClamped<Value: ComparableNumeric> {
    private var value: Value
    public var wrappedValue: Value {
        get { value }
        set {
            value = UpperClamped(
                upperValue: .zero,
                processor: NumericProcessor()
            ).process(newValue)
        }
    }
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}
