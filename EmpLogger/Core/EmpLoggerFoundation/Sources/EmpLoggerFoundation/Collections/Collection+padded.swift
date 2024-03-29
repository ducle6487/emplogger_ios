//
//  Collection+padded.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

import Foundation

extension Collection where Element: Collection {
    public func padded() -> [[Element.Element?]] {
        // Find the largest inner collection based on count
        let largestCollection = self.max(by: { $0.count < $1.count })

        // Map over the inner collections and pad them to match the length of the largest one
        return self.map { collection in
            // Calculate the extra amount needed for padding
            let extraAmount = (largestCollection?.count ?? 0) - collection.count

            // Create an array of optional elements (Element.Element?) from the current collection
            let array: [Element.Element?] = collection.map { $0 }

            // If extraAmount is non-zero, add nil elements to the array for padding
            guard extraAmount > 0 else { return array }
            return array + Array(repeating: nil, count: extraAmount)
        }
    }
}
