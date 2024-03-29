//
//  Preconditions.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

/// Replacement of Swift's `precondition`.
///
/// This will call Swift's `precondition` by default (and terminate the program).
/// Its encapsulated closure can be modified at run time through modifying
/// `Preconditions.closure` for ease of testing without exiting our program, or for
/// swallowing our precondition errors, handling them gracefully or composing further functionality.
public func precondition(
    _ condition: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) {
    Preconditions.closure(condition(), message(), file, line)
}

public struct Preconditions {
    /// Wrapper closure for executing swift's default precondition whilst providing
    /// the ability to swap out at run time for testing.
    public static var closure: (Bool, String, StaticString, UInt) -> Void = defaultPreconditionClosure
    public static let defaultPreconditionClosure = {Swift.precondition($0, $1, file: $2, line: $3)}
}
