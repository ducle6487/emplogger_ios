//
//  LoggableWrapper.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

struct LoggableWrapper: Loggable {
    var loggable: any Loggable
    var literal: String { self.sensitivity == .public ? "\(loggable.literal)" : Self.mask }
    var sensitivity: Sensitivity
    
    init(loggable: some Loggable, sensitivity: Sensitivity) {
        self.loggable = loggable
        self.sensitivity = sensitivity
    }
}

extension Loggable {
    public var `public`: any Loggable { LoggableWrapper(loggable: self, sensitivity: .public) }
    public var `private`: any Loggable { LoggableWrapper(loggable: self, sensitivity: .private) }
}
