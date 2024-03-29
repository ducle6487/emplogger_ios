//
//  AppRootInteractor.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import Combine
import SwiftUI
import Foundation
import CombustionUI
import EmpLoggerCore
//import KineticAuthKit
import EmpLoggerInjection

final class AppRootInteractor: Interactor, AppRootInteracting {
    
    // MARK: - Injection
//    @Inject(\.profileInteractor) var profileInteractor
    @Inject(\.carouselInteractor) var carouselInteractor
//    @Inject(\.onboardingInteractor) var onboardingInteractor
//    @Inject(\.onboardingStore) var onboardingStore
//    @InjectPublished(\.authenticationStore) var authStore
    
    // MARK: - Routing
    @Inject(\.router) var router
    @Inject(\.contractFactory) var contract
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func setup() {
        super.setup()
        // fetch crm profile on launch to determine user's feature access (e.g. energy tab)
//        profileInteractor.fetchCrmProfile()
//        navigateIfFreshInstallOnboarding()
        router.navigate(to: contract.routeToNavigationRoot)
    }
    
//    func navigateIfFreshInstallOnboarding() {
//        if onboardingStore.freshInstall {
//            router.navigate(to: onboardingInteractor.routeToOnboarding { _ in
//                self.router.navigate(to: self.contract.routeToNavigationRoot)
//                // User has completed sign up or skipped, so dont launch to onboarding again
//                self.onboardingStore.freshInstall = false
//            })
//        } else {
//            router.navigate(to: contract.routeToNavigationRoot)
//        }
//    }
    
    // MARK: - View interaction
    func closeCarouselOverlay() {
        carouselInteractor.closeCarouselOverlay()
    }
}

