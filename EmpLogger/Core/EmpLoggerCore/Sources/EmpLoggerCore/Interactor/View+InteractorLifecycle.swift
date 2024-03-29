//
//  File.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import SwiftUI

extension View {
    public func registerInteractorLifecycle(_ interactor: any Interacting) -> some View {
        self.onAppear { interactor.update() }
            .onDisappear { interactor.cancel() }
    }
}
