//
//  Shiny.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion
import CoreMotion
import EmpLoggerInjection

extension View {
    public func shiny(_ surface: Gradient = .electricity) -> some View {
        return ShinyView(surface, content: self)
    }
}

struct ShinyView<Content>: View where Content: View {
    @InjectObservable(\.motionStore) var store
    var surface: Gradient
    var content: Content
    
    init(_ surface: Gradient = .electricity, content: Content) {
        self.surface = surface
        self.content = content
    }
    
    var body: some View {
        self.content
            .foregroundColor(.clear)
            .background(
                GeometryReader { proxy in
                    ZStack {
                        self.surface.stops.last?
                            .color
                            .scaleEffect(self.scale(proxy))
                        
                        RadialGradient(
                            gradient: self.surface,
                            center: .center,
                            startRadius: 1,
                            endRadius: self.radius(proxy))
                            .scaleEffect(self.scale(proxy))
                            .offset(self.position)
                            .animation(.easeInOut, value: position)
                    }
                    .mask(self.content)
                }
            )
    }
}

extension ShinyView {
    var position: CGSize {
        let x = 0 - (CGFloat(store.roll) / .pi * 4) * UIScreen.main.bounds.height
        let y = 0 - (CGFloat(store.pitch) / .pi * 4) * UIScreen.main.bounds.height
        return CGSize(width: x, height: y)
    }
    
    func scale(_ proxy: GeometryProxy) -> CGFloat {
        return UIScreen.main.bounds.height / radius(proxy) * 2
    }
    
    func radius(_ proxy: GeometryProxy) -> CGFloat {
        return min(proxy.frame(in: .global).width / 2, proxy.frame(in: .global).height / 2)
    }
}
