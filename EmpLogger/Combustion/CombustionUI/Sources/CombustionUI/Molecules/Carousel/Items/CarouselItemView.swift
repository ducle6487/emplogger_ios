//
//  CarouselItemView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

// MARK: Shop reward item
public struct CarouselItemView: View, Identifiable {
    @EnvironmentObject private var theme: ThemeProvider
    
    // MARK: - Animation
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
    
    // MARK: - Lifecycle
    public init(id: UUID, image: String, headline: String, description: String) {
        self.id = id
        self.image = image
        self.headline = headline
        self.description = description
    }
    
    // MARK: View composition
    public var body: some View {
        VStack {
            RoundedShape(.extraLarge) {
                VStack(spacing: theme.spacing.compact) {
                    shopRewardImage
                    rewardDetails
                }
                .foregroundColor(theme.colors.onSurface)
            }
            .matchedGeometryEffect(id: "\(id)-background", in: namespace)
        }
    }
}

// MARK: - Reward sections
extension CarouselItemView {
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
        VStack(alignment: .leading) {
            Text(headline)
                .font(.headline)
                .matchedGeometryEffect(id: "\(id)-headline", in: namespace)
            
            Text(description)
                .font(.caption)
                .opacity(0.6)
                .matchedGeometryEffect(id: "\(id)-description", in: namespace)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Previews
struct ShopItem_Previews: PreviewProvider {
    @Namespace static var shopRewardNamespace
    static var previews: some View {
        VStack {
            CarouselItemView(
                id: UUID(),
                image: "",
                headline: "Win $5000 of Milwaukee tools",
                description: "Buy any Four'N Twenty product for your chance to win.*"
            )
            
            CarouselItemView(
                id: UUID(),
                image: "",
                headline: "Win $5000 of Milwaukee tools",
                description: "Buy any Four'N Twenty product for your chance to win.*"
            )
        }
        .padding()
        .previewTheme(for: .light)
    }
}
