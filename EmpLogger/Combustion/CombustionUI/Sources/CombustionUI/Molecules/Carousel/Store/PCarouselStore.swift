//
//  PCarouselStore.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import EmpLoggerCore
import EmpLoggerInjection

public protocol PCarouselStore: Store {
    // MARK: Data state
    
    // MARK: View state
    var isOverlayPresented: Bool { get set }
    var currentPresentedCarouselItem: CarouselItem? { get set }
    
    // MARK: Store funtions
    func presentCarouselOverlay(with carouselItem: CarouselItem)
    func closeCarouselOverlay()
}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct CarouselStoreStoreKey: DependencyKey {
        static var dependency: any PCarouselStore = CarouselStore()
    }
    
    public var carouselStore: any PCarouselStore {
        get { resolve(key: CarouselStoreStoreKey.self) }
        set { register(key: CarouselStoreStoreKey.self, dependency: newValue) }
    }
}
