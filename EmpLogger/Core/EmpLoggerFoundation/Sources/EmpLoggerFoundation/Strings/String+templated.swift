//
//  String+templated.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Foundation

public extension String {
    func masked(pattern: String, exhaustive: Bool = false) -> String {
        Templated(pattern: pattern).mask(input: self, exhaustive: exhaustive)
    }
}

public class Templated {
    typealias Pattern = [Token]

    enum Token: Equatable {
        case digit
        case any
        case letter
        case symbol(Character)

        init(fromCharacter char: Character, config: Config) {
            switch char {
            case config.digitChar: self = .digit
            case config.letterChar: self = .letter
            case config.anyChar: self = .any
            default: self = .symbol(char)
            }
        }
        
        /// Masks a character from token definition
        ///
        /// Replaces the given token or writes a symol
        public func maskCharacter(_ char: Character) -> (Bool, String) {
            let charString = String(char)
            switch self {
            case .digit:
                let isInt = Int(charString) != nil
                return (isInt, isInt ? charString : "")
            case .any:
                return (true, charString)
            case .letter:
                let isLetter = !CharacterSet.letters.isDisjoint(with: CharacterSet(charactersIn: charString))
                return (isLetter, isLetter ? charString : "")
            case .symbol(let symbol):
                return (char == symbol, String(symbol))
            }
        }

        /**
         Process a char according to token configuration but does not write symbols

           Writes either the provided character if matches the token type or returns an empty string
           Note: This serves as a blocking mechanism on text input.

         - Parameter char: The input character being processed
         - Returns: Single character string

         */
        public func read(_ char: Character) -> (Bool, String) {
            let charString = String(char)
            switch self {
            case .digit:
                let isInt = Int(charString) != nil
                return (isInt, isInt ? charString : "")
            case .letter:
                let isLetter = !CharacterSet.letters.isDisjoint(with: CharacterSet(charactersIn: "\(char)"))
                return (isLetter, isLetter ? charString : "")
            case .any:
                return (true, charString)
            case .symbol(let sym):
                return (char == sym, "")
            }
        }

        func toChar(config: Config) -> Character {
            switch self {
            case .digit: return config.digitChar
            case .letter: return config.letterChar
            case .any: return config.anyChar
            case .symbol(let sym): return sym
            }
        }
    }

    /// Configuration used to parse mask pattern
    public struct Config {
        let digitChar: Character
        let anyChar: Character
        let letterChar: Character

        public init(digitChar: Character, anyChar: Character, letterChar: Character = "A") {
            self.digitChar = digitChar
            self.anyChar = anyChar
            self.letterChar = letterChar
        }

        public static var `default`: Config {
            Config(digitChar: "#", anyChar: "*", letterChar: "A")
        }
    }

    // MARK: Properties
    let pattern: Pattern
    let config: Config

    // MARK: Constructors
    init(pattern: Pattern, config: Config = .default) {
        self.pattern = pattern
        self.config = config
    }

    /// Create a template builder with a given pattern
    ///
    /// Legend:
    ///     - `A`: any letters
    ///     - `*`: any characters
    ///     - `#`: any numbers
    public convenience init(pattern string: String, config: Config = .default) {
        let pattern = Self.stringToChars(string).map {
            Token(fromCharacter: $0, config: config)
        }
        self.init(pattern: pattern, config: config)
    }

    /**
     Provide masked

     Note to do live input masking make sure to use non exhuastive option.

     - Parameter input: The input string to process
     - Parameter exhaustive: Wether or not should stop at last token of the pattern.
     - Returns: String masking the input string

     */
    public func mask(input: String, exhaustive: Bool = true) -> String {
        Self.mask(input: input, pattern: pattern, config: config, exhaustive: exhaustive)
    }

    /**
     Provide masked and unmasked versions of input

     Note to do live input masking make sure to use non exhuastive option.

     - Parameter input: The input string to process
     - Parameter exhaustive: Wether or not should stop at last token of the pattern.
     - Returns: A 2 component tuple of masked and unmasked input

     */
    public func process(input: String, exhaustive: Bool = true) -> (masked: String, unmasked: String) {
        Self.process(input: input, pattern: pattern, config: config, exhaustive: exhaustive)
    }

    // MARK: Helpers

    static func stringToChars(_ string: String) -> [Character] {
        let chars = Array(string)
        return chars
    }

    static func patternToString(_ pattern: Pattern, config: Config) -> String {
        String(pattern.map({ $0.toChar(config: config) }))
    }

    static func mask(input: String, pattern: Pattern, config: Config, exhaustive: Bool = true) -> String {
        Self.process(input: input, pattern: pattern, config: config, exhaustive: exhaustive).masked
    }

    static func process(input: String, pattern: Pattern, config: Config, exhaustive: Bool = true) -> (masked: String, unmasked: String) {
        guard let token = pattern.first else {
            return ("", "")
        }

        guard let inputChar = input.first else {
            return exhaustive ? (Self.patternToString(pattern, config: config), "") : ("", "")
        }

        let inputRemaining = input.tail
        let tokensRemaining = Array(pattern.suffix(from: 1))

        let (matches, output) = token.maskCharacter(inputChar)
        let (_, pureInput) = token.read(inputChar)
        
        guard !output.isEmpty else { return (output, pureInput) }
        
        let result = process(
                    input: matches ? String(inputRemaining) : input, pattern: tokensRemaining,
                    config: config,
                    exhaustive: exhaustive)

        return (output + result.masked, pureInput + result.unmasked)
    }
}

extension String {
    var tail: ArraySlice<Character> {
        let chars = Array(self)
        return chars.suffix(from: 1)
    }
}
