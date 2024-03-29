//
//  onVisible.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

extension View {
    public func onVisible(
        parentGeometry: GeometryProxy,
        perform action: @escaping () -> Void
    ) -> some View {
        modifier(OnVisibleModifier(parentGeometry: parentGeometry, action: action))
    }
}

private struct OnVisibleModifier: ViewModifier {
    struct VisibleKey: PreferenceKey {
        static var defaultValue: Bool = false
        static func reduce(value: inout Bool, nextValue: () -> Bool) {}
    }

    var parentGeometry: GeometryProxy
    @State var action: (() -> Void)?

    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: VisibleKey.self,
                        value:
                            parentGeometry
                            .frame(in: .global)
                            .intersects(proxy.frame(in: .global))
                    )
                    .onPreferenceChange(VisibleKey.self) { isVisible in
                        guard isVisible else { return }
                        action?()
                        action = nil
                    }
            }
        }
    }
}
