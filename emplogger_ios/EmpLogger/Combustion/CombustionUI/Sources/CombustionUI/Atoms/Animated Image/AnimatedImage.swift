//
//  AnimatedImage.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Lottie
import Foundation
import EmpLoggerAPI

public enum AnimationError: Error {
    case networkError(response: URLResponse?)
    case invalidFile
}

public struct AnimatedImage: Identifiable {
    public var id = UUID()
    internal var animation: LottieAnimation?
    internal var dotLottie: DotLottieFile?
    
    // MARK: - Interaction methods
    
    /// Asynchronously load an animated image from a remote url
    ///
    /// Loads an animated image from a url and parses its json into a lottie animation.
    /// This lottie animation can be then passed into a lottie view
    ///
    /// - Parameters:
    ///   - url: Url of the json file
    ///   - session: Optional session for request to be executed on
    ///   - animationCache: Optional lottie animation cache to retrieve the image from and store after retrieval
    public static func loadedFrom(
        url: URL,
        animationCache: AnimationCacheProvider = DefaultAnimationCache.sharedCache,
        dotLottieCache: DotLottieCacheProvider = DotLottieCache.sharedCache
    ) async throws -> AnimatedImage {
        // Find our image in cache first
        if let animation = animationCache.animation(forKey: url.absoluteString) {
            return AnimatedImage(animation: animation)
        }
        
        if let animation = dotLottieCache.file(forKey: url.absoluteString) {
            return AnimatedImage(dotLottie: animation)
        }
    
        if url.absoluteString.contains(".lottie") {
            return try await loadDotLottie(from: url, dotLottieCache: dotLottieCache)
        }
            
        // Decode our lottie json from data
        guard let animation = await LottieAnimation.loadedFrom(url: url) else {
            throw AnimationError.networkError(response: nil)
        }
        
        // Save our image for recall in cache
        animationCache.setAnimation(animation, forKey: url.absoluteString)
        
        return AnimatedImage(animation: animation)
    }
    
    private static func loadDotLottie(from url: URL, dotLottieCache: DotLottieCacheProvider) async throws -> AnimatedImage {
        let lottie = try await DotLottieFile.loadedFrom(url: url)
        dotLottieCache.setFile(lottie, forKey: url.absoluteString)
        return AnimatedImage(dotLottie: lottie)
    }
    
    /// Asynchronously load an animated image from local path
    ///
    /// Loads an animated image from a local json file into a lottie animation.
    /// This lottie animation can be then passed into a lottie view
    ///
    /// - Parameters:
    ///   - localPath: Local path to the JSON file
    ///   - animationCache: Optional lottie animation cache to retrieve the image from and store after retrieval
    public static func loadedFrom(
        localPath: String,
        bundle: Bundle = Bundle.main,
        animationCache: AnimationCacheProvider = DefaultAnimationCache.sharedCache
    ) throws -> AnimatedImage {
        // Find our image in cache first
        if let animation = animationCache.animation(forKey: localPath) {
            return AnimatedImage(animation: animation)
        }

        // Decode our lottie json from data
        guard let fileUrl = bundle.url(forResource: localPath, withExtension: ".json") else {
            throw AnimationError.invalidFile
        }
        
        // Decode our file to an animation
        let json = try Data(contentsOf: fileUrl)
        let animation = try LottieAnimation.from(data: json)
        
        // Save our image for recall in cache
        animationCache.setAnimation(animation, forKey: localPath)
        
        return AnimatedImage(animation: animation)
    }
}
