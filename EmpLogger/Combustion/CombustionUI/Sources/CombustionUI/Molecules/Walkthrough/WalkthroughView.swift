//
//  WalkthroughView.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion
import Lottie

// MARK: Shop reward item
public struct WalkthroughView: View {
    @EnvironmentObject private var theme: ThemeProvider
    
    // MARK: - Local properties
    var walkthroughSteps: [WalkthroughStep]
    @Binding var isPlaying: Bool
    
    // If the carousel requires space for a header above the animations i.e. onboarding
    var hasHeader: Bool
    
    // MARK: Local state
    @Binding var selection: UUID
    @State private var childSize: CGSize = CGSize(width: 1, height: 1)
    
    // MARK: - Animation
    @Namespace var namespace
    
    // MARK: - Lifecycle
    public init(
        walkthroughSteps: [WalkthroughStep],
        isPlaying: Binding<Bool>,
        hasHeader: Bool = false,
        selection: Binding<UUID>
    ) {
        self.walkthroughSteps = walkthroughSteps
        self._isPlaying = isPlaying
        self.hasHeader = hasHeader
        self._selection = selection
    }
    
    // MARK: View composition
    public var body: some View {
        walkthroughContent
    }
}

// MARK: - View properties
extension WalkthroughView {
    var currentStep: WalkthroughStep? {
        walkthroughSteps.first(where: { $0.id == selection })
    }
    
    var nextStep: WalkthroughStep? {
        guard let currentStep else { return nil }
        return walkthroughSteps.after(currentStep, loop: true)
    }
}

// MARK: - Walkthrough content
extension WalkthroughView {
    var walkthroughContent: some View {
        walkthrough
    }
    
    // MARK: - Walkthrough
    @ViewBuilder
    var walkthrough: some View {
        // Show empty placeholder when no steps
        if walkthroughSteps.isEmpty {
            EmptyView()
        } else {
            // Only show our TabView if we have walkthrough steps
            SingleAxisGeometryReader { proxy in
                TabView(selection: $selection) {
                    ForEach(walkthroughSteps) { step in
                        buildWalkthroughStep(step, size: proxy)
                        // Tag our step for dynamic selection
                            .tag(step.id)
                    }
                }
            }
            .onAppear {
                // Select our first tab when we appear for the first time
                if let first = walkthroughSteps.first {
                    selection = first.id
                }
            }
            // Ignore the safe area for our background color to extend into header
            .edgesIgnoringSafeArea(.top)
            .tabViewStyle(.page(indexDisplayMode: .never))
            // Animate only our tab transition slides
            .animation(theme.motion.easeInOutSlow, value: selection)
            .transition(.slide)
        }
    }
    
    func buildWalkthroughStep(_ step: WalkthroughStep, size: CGFloat) -> some View {
        // Slide content
        VStack(spacing: theme.spacing.comfortable) {
            AnimatedImageView(id: step.id, animation: step.animation, playing: $isPlaying) { id in
                self.nextWalkthrough(id)
            }
            .padding(.horizontal, step.isFullWidth ? 0 : theme.spacing.spacious*2)
            .frame(width: size, height: size)
            .padding(.top, hasHeader ? 50 : 0) // Header spacing for image
            // Background into safe area
            .background(
                step.isFullWidth
                ? theme.colors.primary.edgesIgnoringSafeArea(.top)
                : Color.clear.edgesIgnoringSafeArea(.top)
            )
            
            // Text content
            Text(step.headline)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, theme.spacing.spacious)

            Text(step.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, theme.spacing.spacious)
            Spacer()
        }
    }
    
    // Slide to our next walkthrough on animation call back
    // and process only the callback on the currently selected animation
    private func nextWalkthrough(_ id: UUID) {
        if let nextStep, selection == id {
            selection = nextStep.id
        }
    }
}

// MARK: - Previews
struct WalkthroughView_Previews: PreviewProvider {
    
    struct Wrapper: View {
        @EnvironmentObject var theme: ThemeProvider
        @State var isPlaying: Bool = true
        @State var currentTabSelection: UUID = UUID()
        @State var steps: [WalkthroughStep] = []
        
        var body: some View {
            VStack {
                WalkthroughView(
                    walkthroughSteps: steps,
                    isPlaying: $isPlaying,
                    selection: $currentTabSelection
                )
                Spacer()
            }
            .task {
                let lottie = try? await DotLottieFile.loadedFrom(
                   url: URL(string: "http://bitly.ws/JXCo")!
                )
                steps = [
                    WalkthroughStep(
                        animation: AnimatedImage(dotLottie: lottie),
                        isFullWidth: true,
                        headline: "Test headline 1",
                        description: "Test description"
                    ),
                    WalkthroughStep(
                        animation: AnimatedImage(dotLottie: lottie),
                        isFullWidth: true,
                        headline: "Test headline 2",
                        description: "Test description 2"
                    ),
                ]
            }
        }
    }
    
    static var previews: some View {
        Wrapper()
            .previewTheme(for: .light)
    }
}
