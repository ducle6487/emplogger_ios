//
//  CarouselNamespace.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

// MARK: - Carousel Namespace

private struct CarouselNamespaceKey: EnvironmentKey {
    static var defaultValue: Namespace.ID?
}

extension EnvironmentValues {
    public var carouselNamespace: Namespace.ID? {
        get { self[CarouselNamespaceKey.self] }
        set { self[CarouselNamespaceKey.self] = newValue }
    }
}
