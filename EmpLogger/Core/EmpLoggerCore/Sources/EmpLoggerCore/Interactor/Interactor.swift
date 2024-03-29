//
//  File.swift
//  
//
//  Created by AnhDuc on 04/03/2024.
//

import Combine
import Foundation
import EmpLoggerFoundation

open class Interactor: Interacting, Logging {
    public var loggerType: LoggingComponent = .interactor
    
    // MARK: - Instance variables
    public var disposables = Set<AnyCancellable>()
    public var tasks = Set<Task<(), Never>>()
    
    // MARK: - Lifecycle
    public init() {
        setup()
    }
    
    /// Setup our Interactor
    ///
    /// Should do the initial Interactor set up for use cases and interactions
    open func setup() {
        log("Setup instance of \(type(of: self))")
        Task { await setup() }.store(in: &tasks)
    }
    
    /// Interactor setup with async execution
    ///
    /// Used for any async code during initial setup of interactor after the
    /// synchronous setup call
    open func setup() async {}
    
    /// Setup one time bindings
    ///
    /// For doing initial binding of data within this Store. Will be called on initialisation
    /// and will exist for the lifecycle of the Interactor.
    open func setupBindings() {}
    
    /// Update our Interactor
    ///
    /// Retrigger any `Store` actions or calls that should refresh on view appear (page load)
    ///
    /// This lifecycle event will be triggered in on appear by `bindInteractorLifecycle()`
    open func update() {
        log("Updating \(type(of: self))")
        setupBindings()
        
        Task { await update() }.store(in: &tasks)
    }
    
    /// Interactor update with async execution
    ///
    /// Used for any async code during update of the interactor after the
    /// synchronous update call
    open func update() async {}
    
    /// Cancel any in flight tasks on this interactor
    ///
    /// Cancel's 'any Store actions or disposable calls that are still in flight for this use case on the
    /// view dissapearing.
    ///
    /// This lifecycle event will be triggered in on disappear by `bindInteractorLifecycle()`
    open func cancel() {
        log("Cancelling in flight requests for \(type(of: self))")
        disposables.cancel()
        tasks.cancel()
    }
}
