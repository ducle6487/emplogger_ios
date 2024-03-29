//
//  CarouselInteractor.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import EmpLoggerCore
import EmpLoggerInjection

final class CarouselInteractor: Interactor, PCarouselInteractor {
    
    // MARK: - Injection
    @Inject(\.carouselStore) var store: any PCarouselStore
    
    // MARK: - Routing
    
    // MARK: - View interaction
    func openCarouselItem(_ item: CarouselItem) {
        store.presentCarouselOverlay(with: item)
    }
    
    func closeCarouselOverlay() {
        store.closeCarouselOverlay()
    }
}
