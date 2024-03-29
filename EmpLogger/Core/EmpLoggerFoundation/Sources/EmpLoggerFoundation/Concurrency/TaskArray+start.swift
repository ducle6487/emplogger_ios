//
//  TaskArray+start.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

extension Array where Element == Task<Void, Error> {
    public mutating func start(
        priority: TaskPriority = .background,
        @_implicitSelfCapture operation: @escaping @Sendable () async throws -> Void
    ) {
        self.append(Task(priority: priority, operation: operation))
    }
}
