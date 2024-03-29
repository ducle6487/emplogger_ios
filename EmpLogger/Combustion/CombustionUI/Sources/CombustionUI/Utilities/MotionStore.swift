//
//  MotionStore.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import CoreMotion
import EmpLoggerCore
import EmpLoggerInjection

protocol MotionStoring: Store {
    var yaw: CGFloat { get }
    var pitch: CGFloat { get }
    var roll: CGFloat { get }
}

class MotionStore: Store, MotionStoring {
    @Published var yaw: CGFloat = 0
    @Published var pitch: CGFloat = 0
    @Published var roll: CGFloat = 0

    var motionInput = CMMotionManager()
    
    override init() {
        super.init()
        
        // Setup motion capturing
        motionInput.deviceMotionUpdateInterval = 0.2
        motionInput.startDeviceMotionUpdates()
        motionInput.startDeviceMotionUpdates(to: OperationQueue.main) { _, _  in
            if let yaw = self.motionInput.yaw,
                let pitch = self.motionInput.pitch,
                let roll = self.motionInput.roll {
                self.yaw = CGFloat(yaw)
                self.pitch = CGFloat(pitch)
                self.roll = CGFloat(roll)
            }
        }
    }
}

extension CMMotionManager {
    var yaw: Double? { return deviceMotion?.attitude.yaw }
    var pitch: Double? { return deviceMotion?.attitude.pitch }
    var roll: Double? { return deviceMotion?.attitude.roll }
}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct MotionStoreKey: DependencyKey {
        static var dependency: any MotionStoring = MotionStore()
    }
    
    var motionStore: any MotionStoring {
        get { resolve(key: MotionStoreKey.self) }
        set { register(key: MotionStoreKey.self, dependency: newValue) }
    }
}
