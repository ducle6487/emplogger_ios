//
//  View+throwingTask.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import SwiftUI

extension View {
    /// Adds an asynchronous task to perform before this view appears.
    ///
    /// Use this modifier to perform an asynchronous task with a lifetime that
    /// matches that of the modified view. If the task doesn't finish
    /// before SwiftUI removes the view or the view changes identity, SwiftUI
    /// cancels the task.
    ///
    /// This modifier provides a catch block for executing any tasks that require a try. Allowing you
    /// to handle any thrown errors appropriately from your view lifecycle.
    ///
    /// Use the `await` keyword inside the task to
    /// wait for an asynchronous call to complete, or to wait on the values of
    /// an <doc://com.apple.documentation/documentation/Swift/AsyncSequence>
    /// instance. For example, you can modify a ``Text`` view to start a task
    /// that loads content from a remote resource:
    ///
    ///     let url = URL(string: "https://example.com")!
    ///     @State private var message = "Loading..."
    ///     @State errorMessage: String?
    ///
    ///     var body: some View {
    ///         Text(message)
    ///             .task {
    ///                 do {
    ///                     var receivedLines = [String]()
    ///                     for try await line in url.lines {
    ///                         receivedLines.append(line)
    ///                         message = "Received \(receivedLines.count) lines"
    ///                     }
    ///                 } catch {
    ///                     message = "Failed to load"
    ///                 }
    ///             } catch: { error in
    ///                 errorMessage = "Something went wrong: \(error.description)"
    ///             }
    ///     }
    ///
    /// - Parameters:
    ///   - priority: The task priority to use when creating the asynchronous
    ///     task. The default priority is
    ///     <doc://com.apple.documentation/documentation/Swift/TaskPriority/3851283-userInitiated>.
    ///   - action: A closure that calls as an asynchronous task
    ///     before the view appears. Will automatically cancel the task after the view disappears
    ///   - catch: A closure that the task will call if an error is thrown from within
    ///
    /// - Returns: A view that runs the specified action asynchronously before
    ///   the view appears with an error handling block
    @inlinable public func task(
        priority: TaskPriority = .userInitiated,
        @_implicitSelfCapture operation: @escaping @Sendable () async throws -> Void,
        @_implicitSelfCapture `catch`: @escaping (Error) async -> Void
    ) -> some View {
        var task: Task<Void, Never>?
        return
            self.onAppear {
                task = Task(priority: priority, operation: operation, catch: `catch`)
            }
            .onDisappear {
                task?.cancel()
            }
    }
}
