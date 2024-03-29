//
//  AppRootView.swift
//  EmpLogger
//
//  Created by AnhDuc on 27/03/2024.
//

import SwiftUI
import Combustion
import CombustionUI
import EmpLoggerCore
//import KineticAuthKit
import EmpLoggerInjection

struct AppRootView: View {
    @Namespace var carouselNamespace
    @EnvironmentObject private var theme: ThemeProvider
    @Environment(\.colorScheme) var deviceColorScheme: ColorScheme
    
    // MARK: - Local state
    @State private var colorSchemeTask: Task<Void, Error>?
    
    // MARK: - Injection
    @Inject(\.appRootInteractor) var interactor
    @InjectObservable(\.router) private var router
    
    // MARK: - App Carousel
    @InjectObservable(\.carouselStore) var carouselStore
    
    // MARK: - View construction
    var body: some View {
        // MARK: Page root
        Page {
            // Compose our subject to our rootView
            router.rootViewSubject?.compose()
        }
        .registerInteractorLifecycle(interactor)
        
        // MARK: Alert
        // Global alert subject for presenting alert
        .alert(isPresented: $router.shouldShowAlert) {
            router.alertSubject
                ?? Alert(
                    title: Text("Something went wrong"),
                    dismissButton: .default(Text("Okay"))
                )
        }
        
        // MARK: Full sheet
        // Global sheet subject for presenting full sheet overlay
        .fullScreenCover(isPresented: $router.shouldShowFullSheetOverlay) {
            StatusBarHost {
                router.fullSheetOverlaySubject?.compose()
            }
            .ignoresSafeArea()
            // Alert subject for surfacing alerts while a sheet is active
            // Will only be triggered if this sheet is presented
            .alert(isPresented: $router.shouldShowAlert) {
                router.alertSubject
                    ?? Alert(
                        title: Text("Something went wrong"),
                        dismissButton: .default(Text("Okay"))
                    )
            }
            // Half sheet subject for surfacing half sheets while a sheet is active
            // Will only be triggered if this sheet is presented
            .halfSheet(isPresented: $router.shouldShowHalfSheetOverSheetOverlay) {
                if let subject = router.halfSheetOverSheetOverlaySubject {
                    subject.compose()
                }
            } onDismiss: {
                router.closeHalfSheet()
            }
        }
        
        // MARK: Modal sheet
        // Global sheet subject for presenting modal sheet overlays
        .sheet(isPresented: $router.shouldShowModalSheetOverlay) {
            router.modalSheetOverlaySubject?.compose()
            // Alert subject for surfacing alerts while a sheet is active
            // Will only be triggered if this sheet is presented
            .alert(isPresented: $router.shouldShowAlert) {
                router.alertSubject
                    ?? Alert(
                        title: Text("Something went wrong"),
                        dismissButton: .default(Text("Okay"))
                    )
            }
        }
        
        // MARK: Half sheet
        .halfSheet(isPresented: $router.shouldShowHalfSheetOverlay) {
            if let subject = router.halfSheetOverlaySubject {
                subject.compose()
            }
        } onDismiss: {
            router.closeHalfSheet()
        }
        
        // MARK: Carousel
        // Global carousel overlay for animating blurred overlay
        .overlay(buildCarouselOverlay())
        .environment(\.carouselNamespace, carouselNamespace)
        
        // MARK: Color scheme
        // Color scheme management for device preferences
        .onAppear {
            theme.change(to: deviceColorScheme)
        }
        .onChange(of: deviceColorScheme) { newScheme in
            colorSchemeTask?.cancel()
            colorSchemeTask = Task {
                /// Debounce our color change so that multiple color changes
                /// are not triggered in succession.
                ///
                /// This occurs in iOS 14+ when an application enters the background
                /// during multitasking. iOS will quickly toggle between `.lightMode` and `.darkMode`
                /// in order to save state for the multitasking preview.
                ///
                /// This is used by iOS multitasking to render the correct preview of an application
                /// in the appropriate device color scheme (if the user changes color schemes whilst the application
                /// is in the background).
                ///
                /// Since our theme is an environment object which causes view recompositions,
                /// this quick toggle succession causes views like NavigationView to pop to root
                /// as the body recomposes.
                ///
                /// To counteract this, we store the change theme task
                /// as a cancellable and cancel the previous task on every trigger.
                /// If the theme change has not finished (after 500ms debounce)
                /// It will discard the first task and only execute the second task.
                try await Task.sleep(seconds: 0.5)
                try Task.checkCancellation()
                await MainActor.run { theme.change(to: newScheme) }
            }
        }
        // Set our status bar default based on current theme
        .statusBarStyle(theme.statusBarColor)
    }
}

// MARK: - Carousel overlay
extension AppRootView {
    
    @ViewBuilder
    func buildCarouselOverlay() -> some View {
        // Present the currently selected carousel item if it exists
        if let current = carouselStore.currentPresentedCarouselItem, carouselStore.isOverlayPresented {
            VStack {
                CarouselOverlay(
                    id: current.id,
                    image: current.imageUrl,
                    headline: current.headline,
                    description: current.description,
                    longDescription: current.longDescription ?? "",
                    footnote: current.footer,
                    validUntil: current.validUntil,
                    dismissAction: {
                        // Trigger our close callback then close the overlay
                        current.closeAction?()
                        interactor.closeCarouselOverlay()
                    },
                    primaryButton: current.primaryButton,
                    secondaryButton: current.secondaryButton
                )
            }
        }
    }
}

// MARK: - Previews
struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
            .previewTheme(for: .light)
    }
}
