//
//  CarouselOverlay.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

// MARK: Carousel item overlay
public struct CarouselOverlay: View, Identifiable {
    @EnvironmentObject private var theme: ThemeProvider
    @Namespace var fallbackNamespace
    @Environment(\.carouselNamespace) var matchedNamespace
    var namespace: Namespace.ID {
        matchedNamespace ?? fallbackNamespace
    }
    
    // MARK: View properties
    public var id: UUID
    public var image: String
    public var headline: String
    public var description: String
    public var longDescription: String
    public var footnote: String?
    public var validUntil: String?
    public var dismissAction: () -> Void
    public var primaryButton: CombustionButton?
    public var secondaryButton: CombustionButton?
    
    public init(
        id: UUID,
        image: String,
        headline: String,
        description: String,
        longDescription: String,
        footnote: String? = nil,
        validUntil: String? = nil,
        dismissAction: @escaping () -> Void,
        primaryButton: CombustionButton? = nil,
        secondaryButton: CombustionButton? = nil
    ) {
        self.id = id
        self.image = image
        self.headline = headline
        self.description = description
        self.longDescription = longDescription
        self.footnote = footnote
        self.validUntil = validUntil
        self.dismissAction = dismissAction
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
    
    // MARK: Local animation
    @State private var animateDetails: Bool = false
    @State private var animateCtas: Bool = false
    @State private var dragOffset: CGFloat = .zero
    private var maxDrag: CGFloat = 100
    
    // MARK: View composition
    public var body: some View {
        // Place our shop reward on a blurred background
        // to force user's attention switch
        BlurredBackground(.systemUltraThinMaterial) {
            overlayContent
                // Scale our content relative to the drag offset to simulate closing
                .scaleEffect(1-(dragOffset/maxDrag)/10)
        } onTap: {
            executeDismiss()
        }
        .swipeClose(dragOffset: $dragOffset, maxDrag: maxDrag) {
            executeDismiss()
        }
    }
}

// MARK: - Reward sections
extension CarouselOverlay {
    // Shop reward card with content
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: theme.spacing.compact) {
            closeButton
            shopCard
            callToActions
        }
        .padding(theme.spacing.comfortable)
    }
    
    // Floating close button above card
    var closeButton: some View {
        Button(action: {
            executeDismiss()
        }) {
            RoundedShape(.large, backgroundColor: theme.colors.surface) {
                Image(systemName: "xmark")
                    .font(.subheadline.bold())
                    .foregroundColor(theme.colors.onBackground)
            }
            .padding(.horizontal, theme.spacing.compact)
        }
        .buttonStyle(.scaledOpacity)
    }
    
    // Floating card overlay
    var shopCard: some View {
        RoundedShape(.extraLarge) {
            VStack(spacing: theme.spacing.compact) {
                shopRewardImage
                rewardDetails
            }
            .foregroundColor(theme.colors.onSurface)
        }
        .matchedGeometryEffect(id: "\(id)-background", in: namespace)
    }
    
    // Button dismiss action for reuse in touch outside and close button
    private func executeDismiss() {
        // Animate our details off of the view
        withAnimation(theme.motion.easeInOutSlow) {
            animateCtas = false
        }
        withAnimation(theme.motion.easeInOutSlow.delay(.delaySlow)) {
            animateDetails = false
        }
        // Using dispatch queue asnycAfter here since chaining withAnimations
        // can lead to swiftui overriding animations and unpredictable behaviour
        // even if using .delay()
        DispatchQueue.main.asyncAfter(deadline: .now() + .delaySlow) {
            withAnimation(theme.motion.easeInOutSlow) {
                dismissAction()
            }
        }
    }
}

// MARK: - Shop card content
extension CarouselOverlay {
    // Full width hero shop image
    var shopRewardImage: some View {
        RoundedShape(.large, padding: .zero) {
            CachedImage(url: image) { phase in
                switch phase {
                case .loading:
                    CombustionImages.Placeholders.shopReward
                        .resizable()
                        .scaledToFit()
                case .loaded(let image):
                    image
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .matchedGeometryEffect(id: "\(id)-image", in: namespace)
    }
    
    // Rewards details
    var rewardDetails: some View {
        VStack(alignment: .leading, spacing: theme.spacing.comfortable) {
            defaultDetails
            extraDetails
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            withAnimation(theme.motion.easeInOutMedium.delay(.delayMedium)) {
                animateDetails = true
            }
            withAnimation(theme.motion.easeInOutSlow.delay(.delaySlow)) {
                animateCtas = true
            }
        }
    }

    var defaultDetails: some View {
        VStack(alignment: .leading, spacing: theme.spacing.squishy) {
            Text(headline)
                .font(.headline)
                .matchedGeometryEffect(id: "\(id)-headline", in: namespace)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            Text(description)
                .font(.caption)
                .opacity(0.6)
                .matchedGeometryEffect(id: "\(id)-description", in: namespace)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    var extraDetails: some View {
        let hasFooter = !(footnote?.isEmpty ?? true) || !(validUntil?.isEmpty ?? true)
        if animateDetails && (hasFooter || !longDescription.isEmpty) {
            VStack(alignment: .leading, spacing: theme.spacing.cozy) {
                if !longDescription.isEmpty {
                    Text(longDescription)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                }
                
                if hasFooter {
                    HStack(alignment: .bottom) {
                        if let footnote {
                            Text(footnote)
                                .font(.caption)
                                .opacity(0.6)
                        }
                        if let validUntil {
                            Spacer()
                            Text("Valid till \(validUntil)")
                                .font(.caption)
                                .opacity(0.6)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .transition(.opacity)
        }
    }
}

// MARK: - Call to actions
extension CarouselOverlay {
    @ViewBuilder
    var callToActions: some View {
        if animateCtas {
            VStack(spacing: theme.spacing.compact) {
                primaryButton
                secondaryButton
            }
        }
    }
}

// MARK: - Previews
struct ShopRewardOverlay_Previews: PreviewProvider {
    @Namespace static var shopRewardNamespace
    @State static var isPresented: Bool = true
    static var previews: some View {
        VStack {
            CarouselOverlay(
                id: UUID(),
                image: "",
                headline: "Win $5000 of Milwaukee tools",
                description: "Description of tools",
                longDescription: """
                You must request the entry
                card if not automatically provided and visit winwith4n20.com.au.
                Follow the prompts and fully complete and submit the online entry.
                """,
                footnote: "",
                validUntil: "",
                dismissAction: {},
                primaryButton: CombustionButton(
                    title: "Check my address",
                    type: .primary,
                    enabled: true,
                    loading: false,
                    action: {}()
                ),
                secondaryButton: CombustionButton(
                    title: "More details",
                    type: .secondary,
                    enabled: true,
                    loading: false,
                    action: {}()
                )
            )
        }
        .previewTheme(for: .light)
    }
}
