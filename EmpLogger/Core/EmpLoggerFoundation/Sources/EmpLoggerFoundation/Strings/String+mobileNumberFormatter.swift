//
//  String+mobileNumberFormatter.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

extension String {
    // update as nation phone number
    public func asMobileNumber() -> String {
        let number = self.replacingOccurrences(of: " ", with: "")
        guard number != "0", !number.isEmpty else {
            return number
        }
        
        switch number.count {
        case 0 - 9: return number
        case 10: return insertSpaces(number: number, at: [4, 8])
        case 11: return insertSpaces(number: number, at: [2, 6, 10])
        case 12: return insertSpaces(number: number, at: [3, 7, 11])
        default: return number
        }
    }
    
    private func insertSpaces(number: String, at indexes: [Int]) -> String {
        var newNumber = number
        let insertSpacesAt = indexes.sorted()
        for index in insertSpacesAt {
            newNumber.insert(" ", at: String.Index(utf16Offset: index, in: newNumber))
        }
        return newNumber
    }
}
