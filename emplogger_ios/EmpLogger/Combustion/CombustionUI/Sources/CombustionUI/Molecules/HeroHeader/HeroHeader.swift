//
//  HeroHeader.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Graphics
import Combustion

public struct HeroHeader: View {
    @EnvironmentObject var theme: ThemeProvider

    @State private var cloudAnimation: AnimatedImage?
    @State private var isCloudsPlaying = true
    private var heroType: HeroImage

    private enum HeroImage {
        case remote(url: String, fallback: Image)
        case singleImage(_ hero: Image)
        case layered(middleground: Image, foreground: Image)
    }

    public init(hero: Image) {
        heroType = .singleImage(hero)
    }

    public init(middleground: Image, foreground: Image) {
        heroType = .layered(middleground: middleground, foreground: foreground)
    }

    public init(url: String, fallback: Image) {
        heroType = .remote(url: url, fallback: fallback)
    }

    public var body: some View {
        VStack {
            Spacer(minLength: 0)
            switch heroType {
            case .remote(let url, let fallback):
                buildHero(url: url, fallback: fallback)
            case .singleImage(let image):
                buildHero(for: image)
            case .layered(let middleground, let foreground):
                buildHero(middleground: middleground, foreground: foreground)
            }
        }
        .aspectRatio(CGSize(width: 5, height: 3), contentMode: .fit)
        .background(
            // Background color with cloud overlay as a background to hero
            // so that our cloud animation frames are preserved
            // through state changes, and continue to animate
            theme.colors.primary
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .top)
                .overlay(
                    clouds
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea(edges: .top)
                )
                .padding(.bottom, theme.spacing.roomy)
        )
        .swallowTask { @MainActor in
            self.cloudAnimation = try AnimatedImage.loadedFrom(localPath: "forecourtclouds")
        }
    }

    func buildHero(middleground: Image, foreground: Image) -> some View {
        ZStack {
            middleground
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)

            foreground
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }

    func buildHero(for hero: Image) -> some View {
        hero
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }

    func buildHero(url: String, fallback: Image) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        } placeholder: {
            fallback
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder
    var clouds: some View {
        if let cloudAnimation {
            AnimatedImageView(animation: cloudAnimation, playing: $isCloudsPlaying, loopMode: .loop)
        }
    }
}

struct HeroHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

        }
        //        VStack {
        //            HeroHeader(url: "", fallback: Images.Energy.Houses.mainHouse)
        //            Spacer()
        //        }
        //        .ignoresSafeArea(.all)
        //        .frame(alignment: .top)
        //        .previewTheme(for: .light)
        //
        //        VStack {
        //            HeroHeader(hero: Images.Energy.Houses.mainHouse)
        //            Spacer()
        //        }
        //        .ignoresSafeArea(.all)
        //        .frame(alignment: .top)
        //        .previewTheme(for: .light)
        //
        //        VStack {
        //            HeroHeader(hero: Images.Onroad.Heros.onroadSelectorHero)
        //            Spacer()
        //        }
        //        .ignoresSafeArea(.all)
        //        .frame(alignment: .top)
        //        .previewTheme(for: .light)
        //
        //        VStack {
        //            HeroHeader(
        //                middleground: Images.Onroad.Heros.fuelpayMg,
        //                foreground: Images.Onroad.Heros.fuelpayFg
        //            )
        //            Spacer()
        //        }
        //        .ignoresSafeArea(.all)
        //        .frame(alignment: .top)
        //        .previewTheme(for: .light)
        //
        //        VStack {
        //            HeroHeader(
        //                middleground: Images.Onroad.Heros.ampchargeMg,
        //                foreground: Images.Onroad.Heros.ampchargeFg
        //            ).pageTheme(BaseTheme())
        //            Spacer()
        //        }
        //        .ignoresSafeArea(.all)
        //        .frame(alignment: .top)
        //        .previewTheme(for: .light)
    }
}
