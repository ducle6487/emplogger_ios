//
//  PlaceholderCarouselItemView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

// MARK: Shop reward item
public struct PlaceholderCarouselItemView: View {
    @EnvironmentObject private var theme: ThemeProvider
    
    // MARK: - Animation
    @Namespace var fallbackNamespace
    @Environment(\.carouselNamespace) var matchedNamespace
    var namespace: Namespace.ID {
        matchedNamespace ?? fallbackNamespace
    }
    
    // MARK: View properties
    
    // MARK: - Lifecycle
    public init() {}
    
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
            .shimmering()
        }
    }
}

// MARK: - Reward sections
extension PlaceholderCarouselItemView {
    // Full width hero shop image
    var shopRewardImage: some View {
        RoundedShape(.large, padding: .zero) {
            CombustionImages.Placeholders.shopReward
                .resizable()
                .scaledToFit()
        }
    }
    
    // Rewards details
    var rewardDetails: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: theme.radius.large)
                .foregroundColor(theme.colors.background)
                .frame(maxWidth: 200, maxHeight: 17)
            
            RoundedRectangle(cornerRadius: theme.radius.large)
                .foregroundColor(theme.colors.background)
                .frame(maxHeight: 17)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Previews
struct PlaceholderCarouselItemView_Previews: PreviewProvider {
    @Namespace static var shopRewardNamespace
    static var previews: some View {
        VStack {
            PlaceholderCarouselItemView()
            PlaceholderCarouselItemView()
        }
        .padding()
        .previewTheme(for: .light)
    }
}
