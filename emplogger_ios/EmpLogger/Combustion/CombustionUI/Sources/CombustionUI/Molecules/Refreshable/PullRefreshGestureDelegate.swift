//
//  PullRefreshGestureDelegate.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

class PullRefreshGestureDelegate: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    static var maxDrag: CGFloat = 100
    var panGesture: UIPanGestureRecognizer?
    
    @Published var canRefresh: Bool = false
    @Published var contentOffset: CGFloat = 0
    @Published var otherOffset: CGFloat = 0
    @Published var offset: CGFloat = 0
    @Published var progress: CGFloat = 0
    
    var rootController: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        // Enable simultaneous gestures so we dont interfere with scrollview
        return true
    }
    
    // MARK: - Gesture lifecycle
    func addGesture() {
        panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(onGestureChange(gesture:))
        )
        
        panGesture?.delegate = self
        rootController.view.addGestureRecognizer(panGesture!)
    }
    
    func removeGesture() {
        if let panGesture {
            rootController.view.removeGestureRecognizer(panGesture)
        }
    }
    
    @objc func onGestureChange(gesture: UIPanGestureRecognizer) {
        // Set the state to can refresh if the user dragged enough
        if gesture.state == .cancelled || gesture.state == .ended {
            if offset > Self.maxDrag {
                canRefresh = true
            }
        }
    }
}
