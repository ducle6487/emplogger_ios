//
//  CarouselView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion
import EmpLoggerInjection

// MARK: Carousel
public struct Carousel: View {
    @EnvironmentObject private var theme: ThemeProvider
    @Inject(\.carouselInteractor) var interactor: any PCarouselInteractor
    @InjectObservable(\.carouselStore) var store: any PCarouselStore
    
    // MARK: - Animation
    @Namespace var fallbackNamespace
    @Environment(\.carouselNamespace) var matchedNamespace
    var namespace: Namespace.ID {
        matchedNamespace ?? fallbackNamespace
    }
    
    // MARK: View properties
    var carouselItems: [CarouselItem]
    
    public init(carouselItems: [CarouselItem]) {
        self.carouselItems = carouselItems
    }
    
    // MARK: View composition
    public var body: some View {
        SingleAxisGeometryReader { width in
            ScrollView(.horizontal, showsIndicators: false) {
                /// Using HStack instead of LazyHStack
                /// since we are animating transitions and state in the horizontal
                /// scrollview. If a user were to swipe whilst animating an error will occur
                /// Horizontal scrolls should not contain too many items and still be performant
                HStack(alignment: .top, spacing: theme.spacing.comfortable) {
                    // Build our carousel items
                    ForEach(carouselItems, id: \.id) { item in
                        /// Show full width item if there is only one
                        /// Otherwise make it smaller so we can partially see
                        /// the next item
                        let itemWidth = carouselItems.count > 1
                            // 80% of the full width of the parent view
                            ? width * 0.8
                            // Full width of the view - the inset padding on each side
                            : width - 2*theme.spacing.comfortable
                        
                        // Build our carousel and frame it
                        buildCarouselItem(item)
                            .transition(.identity)
                            .frame(width: itemWidth)
                    }
                }
                .padding(.horizontal, theme.spacing.comfortable)
            }
        }
    }
}

// MARK: - Reward sections
extension Carousel {
    
    @ViewBuilder
    func buildCarouselItem(_ item: CarouselItem) -> some View {
        Button {
            withAnimation(theme.motion.easeInOutSlow) {
                // Trigger our open action then open carousel
                item.openAction?()
                interactor.openCarouselItem(item)
            }
        } label: {
            /// Remove the view ID property when our presenting overlay is open in
            /// order for a copy of the parent to exist as well as the new animated view.
            /// This leaves behind a copy during animation in the exisining place within the carousel.
            /// Without this, the carousel will jump places when the item is removed for animation.
            ///
            /// The view with the matched identity will animate leaving the copy behind.
            /// We are using an if here rather than turnary inside the ID, to force separate view identities
            /// and trigger transition animations.
            if !store.isOverlayPresented || item.id != store.currentPresentedCarouselItem?.id {
                // Match our view identity to our ovelay for matched geometry animation
                CarouselItemView(
                    id: item.id,
                    image: item.imageUrl,
                    headline: item.headline,
                    description: item.description
                )
            } else {
                // Create a placeholder shop reward item with new view identity
                CarouselItemView(
                    id: UUID(),
                    image: item.imageUrl,
                    headline: item.headline,
                    description: item.description
                )
            }
        }
        .buttonStyle(.scaledOpacity)
    }
}

// MARK: - Previews
struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(
            carouselItems: [
                CarouselItem(
                    imageUrl: "",
                    headline: "Win $5000 of Milwaukee tools",
                    description: "Some description",
                    longDescription: "Some long description",
                    footer: ""
                ),
                CarouselItem(
                    imageUrl: "",
                    headline: "Some headline",
                    description: "Some description",
                    longDescription: "Some long description",
                    footer: ""
                ),
            ]
        )
        .previewTheme(for: .light)
    }
}
