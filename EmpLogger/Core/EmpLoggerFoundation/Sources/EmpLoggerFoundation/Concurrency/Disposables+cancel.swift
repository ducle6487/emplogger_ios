//
//  Disposables+cancel.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import Combine

extension Collection where Element: AnyCancellable {
    public func cancel() {
        self.forEach { disposable in
            disposable.cancel()
        }
    }
}

extension Task {
    public func store(in set: inout Set<Task<Success, Failure>>) {
        set.insert(self)
    }
}

extension Collection where Element == Task<(), Never> {
    public func cancel() {
        self.forEach { task in
            task.cancel()
        }
    }
}

extension Collection where Element == Task<(), Error> {
    public func cancel() {
        self.forEach { task in
            task.cancel()
        }
    }
}
