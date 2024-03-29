//
//  View+scenePhaseChange.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

struct ScenePhaseChangeModifier: ViewModifier {
    @Environment (\.scenePhase) var scenePhase
    
    var activeAction: () -> Void
    var inactiveAction: () -> Void
    var backgroundAction: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active: activeAction()
                case .inactive: inactiveAction()
                case .background: backgroundAction()
                default: return
                }
            }
    }
}

extension View {
    public func onScenePhaseChange(
        activeAction: @escaping () -> Void = {},
        inactiveAction: @escaping () -> Void = {},
        backgroundAction: @escaping () -> Void = {}
    ) -> some View {
       modifier(ScenePhaseChangeModifier(
        activeAction: activeAction,
        inactiveAction: inactiveAction,
        backgroundAction: backgroundAction
       ))
    }
}
