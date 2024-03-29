//
//  CarouselStore.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import EmpLoggerCore
import EmpLoggerInjection

final class CarouselStore: Store, PCarouselStore {
    
    // MARK: - Injection
    
    // MARK: - Routing
    
    // MARK: - Instance properties
    @Published var isOverlayPresented: Bool = false
    @Published var currentPresentedCarouselItem: CarouselItem?
    
    // MARK: - Lifecycle
    override func setup() {
        super.setup()
    }
    
    // MARK: - Updates
    func presentCarouselOverlay(with carouselItem: CarouselItem) {
        currentPresentedCarouselItem = carouselItem
        isOverlayPresented = true
    }
    
    func closeCarouselOverlay() {
        currentPresentedCarouselItem = nil
        isOverlayPresented = true
    }
}
