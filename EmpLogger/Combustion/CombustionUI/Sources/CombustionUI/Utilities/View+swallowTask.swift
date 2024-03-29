//
//  View+swallowTask.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import EmpLoggerCore
import EmpLoggerInjection

extension View {
    public func swallowTask(
        priority: TaskPriority = .userInitiated,
        _ action: @escaping @Sendable () async throws -> Void
    ) -> some View {
        self.task {
            do {
                try await action()
            } catch {
                DependencyMap.resolve(\.logger).log("Swallowing Error: \(error.localizedDescription)", .error, .error)
            }
        }
    }
}
