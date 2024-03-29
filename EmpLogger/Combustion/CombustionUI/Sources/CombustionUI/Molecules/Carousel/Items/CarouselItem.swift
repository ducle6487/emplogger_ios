//
//  CarouselItem.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

public struct CarouselItem: Identifiable {
    public var id: UUID
    public var imageUrl: String
    public var headline: String
    public var description: String
    public var longDescription: String?
    public var footer: String?
    public var validUntil: String?
    public var openAction: ButtonAction?
    public var closeAction: ButtonAction?
    public var primaryButton: CombustionButton?
    public var secondaryButton: CombustionButton?
    
    public init(
        id: UUID = UUID(),
        imageUrl: String,
        headline: String,
        description: String,
        longDescription: String? = nil,
        footer: String? = nil,
        validUntil: String? = nil,
        openAction: ButtonAction? = nil,
        closeAction: ButtonAction? = nil,
        primaryButton: CombustionButton? = nil,
        secondaryButton: CombustionButton? = nil
    ) {
        self.id = id
        self.imageUrl = imageUrl
        self.headline = headline
        self.description = description
        self.longDescription = longDescription
        self.footer = footer
        self.validUntil = validUntil
        self.openAction = openAction
        self.closeAction = closeAction
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
}
