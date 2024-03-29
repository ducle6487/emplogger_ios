//
//  Collection+chunkedBy.swift
//  Base
//
//  Created by AnhDuc on 29/02/2024.
//

import Foundation

extension Collection where Index: Strideable, Index.Stride == Int {
    /// Splits the collection into subsequences of a specified length.
    ///
    /// - Parameter chunkSize: The length of each subsequence.
    /// - Returns: A collection of subsequences.
    public func chunked(by chunkSize: Self.Index.Stride) -> [[Element]] {
        let indices = stride(from: self.startIndex, to: self.endIndex, by: chunkSize)
        return indices.map { startIndex in
            let endIndex = self.index(startIndex, offsetBy: chunkSize, limitedBy: self.endIndex) ?? self.endIndex
            return Array(self[startIndex..<endIndex])
        }
    }
}
