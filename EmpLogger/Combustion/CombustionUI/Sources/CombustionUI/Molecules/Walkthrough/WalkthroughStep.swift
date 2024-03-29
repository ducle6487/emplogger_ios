//
//  WalkthroughStep.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation
import Combustion

public struct WalkthroughStep: Identifiable, Equatable {
    public var id: UUID
    public var url: URL?
    public var localFile: String?
    public var animation: AnimatedImage?
    public var isFullWidth: Bool
    public var headline: String
    public var description: String
    
    public init(
        id: UUID = UUID(),
        url: URL? = nil,
        localFile: String? = nil,
        animation: AnimatedImage? = nil,
        isFullWidth: Bool = false,
        headline: String, description: String
    ) {
        self.id = id
        self.url = url
        self.localFile = localFile
        self.animation = animation
        self.isFullWidth = isFullWidth
        self.headline = headline
        self.description = description
    }
    
    public static func == (lhs: WalkthroughStep, rhs: WalkthroughStep) -> Bool {
        lhs.id == rhs.id
    }
}
