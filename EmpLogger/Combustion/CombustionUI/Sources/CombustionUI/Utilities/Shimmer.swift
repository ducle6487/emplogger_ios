//
//  Shimmer.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

/// A view modifier that applies an animated "shimmer" to any view, typically to show that an operation is in progress.
public struct Shimmer: ViewModifier {
    @Environment(\.layoutDirection) private var layoutDirection
    
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    @State private var isInitialState = true

    /// Initializes his modifier with a custom animation,
    /// - Parameters:
    ///   - animation: A custom animation. Defaults to ``defaultAnimation``.
    ///   - gradient: A custom gradient. Defaults to ``defaultGradient``.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 30% of the extent of the gradient.
    public init(
        animation: Animation?,
        gradient: Gradient?,
        bandSize: CGFloat = 1
    ) {
        self.animation = animation ?? defaultAnimation
        self.gradient = gradient ?? defaultGradient
        // Calculate unit point dimensions beyond the gradient's edges by the band size
        self.min = 0 - bandSize
        self.max = 1 + bandSize
    }

    /// The default animation effect.
    public let defaultAnimation = Animation.easeInOut(duration: 1.5).delay(0.25).repeatForever(autoreverses: false)

    // A default gradient for the animated mask.
    public let defaultGradient = Gradient(colors: [
        .black.opacity(0.6),
        .black,
        .black.opacity(0.6),
    ])

    /*
     Calculating the gradient's animated start and end points:
     min,min
        \
         ┌───────┐         ┌───────┐
         │0,0    │ Animate │       │  "forward" gradient
     LTR │       │ ───────►│    1,1│  / // /
         └───────┘         └───────┘
                                    \
                                  max,max
                max,min
                  /
         ┌───────┐         ┌───────┐
         │    1,0│ Animate │       │  "backward" gradient
     RTL │       │ ───────►│0,1    │  \ \\ \
         └───────┘         └───────┘
                          /
                       min,max
     */

    /// The start point of our gradient, adjusting for layout direction.
    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    /// The end point of our gradient, adjusting for layout direction.
    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    public func body(content: Content) -> some View {
        content
            .mask(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
            .task {
                try? await Task.sleep(seconds: 0.01)
                withAnimation(animation) {
                    isInitialState = false
                }
            }
    }
}

public extension View {
    /// Adds an animated shimmering effect to any view, typically to show that an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - animation: A custom animation.
    ///   - gradient: A custom gradient.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 0.3 unit points, which corresponds to
    /// 30% of the extent of the gradient.
    @ViewBuilder func shimmering(
        active: Bool = true,
        animation: Animation? = nil,
        gradient: Gradient? = nil,
        bandSize: CGFloat = 1
    ) -> some View {
        if active {
            modifier(Shimmer(animation: animation, gradient: gradient, bandSize: bandSize))
        } else {
            self
        }
    }
}

// MARK: - Previews
struct Shimmer_Previews: PreviewProvider {
    @StateObject static var theme = ThemeProvider(with: .light)
    
    static var previews: some View {
        Group {
            VStack(alignment: .leading) {
                Text(String(repeating: "Shimmer", count: 12))
                    .redacted(reason: .placeholder)
            }.frame(maxWidth: 200)
        }
        .padding()
        .shimmering()
        .previewLayout(.sizeThatFits)
    }
}
