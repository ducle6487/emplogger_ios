//
//  Store.swift
//
//
//  Created by AnhDuc on 04/03/2024.
//

import Combine

open class Store: Storing, Logging {
    public var loggerType: LoggingComponent = .store
    
    // MARK: - Instance variables
    public var disposables = Set<AnyCancellable>()
    public var tasks = Set<Task<(), Never>>()
    
    // MARK: - Lifecycle
    public init() {
        setup()
    }
    
    /// Setup our Store at instantation
    ///
    /// Should do the initial Store set up when first created (created before the view's existence
    /// for injection)
    open func setup() {
        log("Setup instance of \(type(of: self))")
        setupBindings()
        
        Task { await setup() }.store(in: &tasks)
    }
    
    /// Store setup with async execution
    ///
    /// Used for any async code during initial setup of store initial Store after the
    /// synchronous setup call
    open func setup() async {}
    
    /// Setup one time bindings
    ///
    /// For doing initial binding of data within this Store. Will be called on initialisation
    /// and will exist for the lifecycle of the Store.
    open func setupBindings() {}
    
    /// Cancel async tasks
    ///
    /// Cancel any API calls or bindings that are still in flight
    ///
    /// This should be called from  viewDissapear inside a SwiftUI content block
    /// and will setup our Store for use
    open func cancel() {
        log("Cancelling in flight requests for \(type(of: self))")
        disposables.cancel()
    }
}
