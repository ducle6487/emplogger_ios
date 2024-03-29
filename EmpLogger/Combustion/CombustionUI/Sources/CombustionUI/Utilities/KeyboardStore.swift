//
//  KeyboardStore.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Combine
import SwiftUI
import EmpLoggerCore
import EmpLoggerInjection

public class KeyboardStore: Store {
    @Published public var keyboardVisible = false
    @Published public var keyboardHeight: CGFloat = 0
    
    public override func setup() {
        // Setup our keyboard forwarding
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map {
                        self.keyboardHeight = $0.keyboardHeight
                        return true
                    },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in
                        self.keyboardHeight = 0
                        return false
                    }
            )
            .sink { visible in
                self.keyboardVisible = visible
            }
            .store(in: &disposables)
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension DependencyMap {
    private struct KeyboardStoreKey: DependencyKey {
        static var dependency: KeyboardStore = KeyboardStore()
    }
    
    public var keyboardStore: KeyboardStore {
        get { resolve(key: KeyboardStoreKey.self) }
        set { register(key: KeyboardStoreKey.self, dependency: newValue) }
    }
}
