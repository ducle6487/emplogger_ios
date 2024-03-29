//
//  AnimatedImageView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Lottie
import SwiftUI
import Combine
import Combustion

public struct AnimatedImageView: UIViewRepresentable {
    public typealias AnimationCompletionCallback = (UUID) -> Void
    private static let animationViewTag = 1000
    @EnvironmentObject private var theme: ThemeProvider
    
    // MARK: - Instance Properties
    var id: UUID
    @Binding var isPlaying: Bool
    var loopMode: LottieLoopMode
    var animation: AnimatedImage?
    var callback: AnimationCompletionCallback?
    
    // MARK: - Lottie Lifecycle
    
    /// Custom lottie view
    ///
    /// Lottie view that can be used to host a lottie file for animation within the application
    ///
    /// - Parameters:
    ///   - animation: Title text for button.
    ///   - isEnabled: Optional binding of the enabled state of the button to the Store
    ///   - isLoading: Optional binding of the loading state of the button to the Store
    ///   - type: `CombustionButtonType` to determine style of button
    ///   - action: Action closure that will be triggered on click
    public init(
        id: UUID = UUID(),
        animation: AnimatedImage?,
        playing: Binding<Bool>,
        loopMode: LottieLoopMode = .playOnce,
        callback: AnimationCompletionCallback? = nil
    ) {
        self.id = id
        self._isPlaying = playing
        self.loopMode = loopMode
        self.animation = animation
        self.callback = callback
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        addLottie(to: view)
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        uiView.subviews.forEach { view in
            // Find our lottie view and animate it
            if view.tag == AnimatedImageView.animationViewTag, let lottie = view as? LottieAnimationView {
                play(lottie: lottie)
            }
        }
    }
    
    // MARK: - Private helpers
    
    private func addLottie(to view: UIView) {
        let lottie = animation?.animation != nil
            ? LottieAnimationView(animation: animation?.animation)
            : LottieAnimationView(dotLottie: animation?.dotLottie)
        
        lottie.backgroundColor = .clear
        lottie.translatesAutoresizingMaskIntoConstraints = false
        
        // Add our animation to the lottie container
        lottie.loopMode = loopMode
        
        // Tag for retrieval and animating
        lottie.tag = AnimatedImageView.animationViewTag
        view.addSubview(lottie)
        
        // Constrain our lottie to the size of the SwiftUI wrapper
        NSLayoutConstraint.activate([
            lottie.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottie.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    private func play(lottie: LottieAnimationView) {
        if isPlaying {
            lottie.play { completion in
                if completion { callback?(id) }
            }
        } else {
            lottie.stop()
        }
    }
}

// MARK: - Previews
struct AnimatedImageView_Previews: PreviewProvider {
    
    struct Wrapper: View {
        @EnvironmentObject var theme: ThemeProvider
        @State var isPlaying: Bool = true
        @State var animation: AnimatedImage?
        
        var body: some View {
            VStack {
                Group {
                    if let animation {
                        AnimatedImageView(animation: animation, playing: $isPlaying)
                    } else {
                        Text("Loading")
                    }
                }
                Spacer()
            }
            .task {
                let lottie = try? await DotLottieFile.loadedFrom(
                   url: URL(string: "https://shorturl.at/bhkmr")!
                )
                animation = AnimatedImage(dotLottie: lottie)
            }
        }
    }
    
    static var previews: some View {
        Wrapper()
            .previewTheme(for: .light)
    }
}
