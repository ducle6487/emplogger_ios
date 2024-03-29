//
//  StoreState+Ext.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import EmpLoggerCore

extension StoreState {
    @ViewBuilder
    public func buildViewFromState(
        @ViewBuilder loadedBlock: (DataType) -> some View,
        @ViewBuilder loadingBlock: (DataType?) -> some View,
        @ViewBuilder errorBlock: (Error) -> some View
    ) -> some View {
        switch self {
        case .loaded(let loaded):
            loadedBlock(loaded)
        case .loading(let loading):
            loadingBlock(loading)
        case .error(let error):
            errorBlock(error)
        }
    }
    
    @ViewBuilder
    public func buildViewFromState(
        @ViewBuilder loadedBlock: (DataType) -> some View,
        @ViewBuilder errorBlock: (Error) -> some View
    ) -> some View {
        switch self {
        case .loaded(let loaded):
            loadedBlock(loaded)
        case .loading:
            GenericLoadingView()
        case .error(let error):
            errorBlock(error)
        }
    }
    
    @ViewBuilder
    public func buildViewFromState(
        @ViewBuilder loadedBlock: (DataType) -> some View,
        @ViewBuilder loadingBlock: (DataType?) -> some View
    ) -> some View {
        switch self {
        case .loaded(let loaded):
            loadedBlock(loaded)
        case .loading(let loading):
            loadingBlock(loading)
        case .error:
            GenericErrorView()
        }
    }
    
    @ViewBuilder
    public func buildViewFromState(
        @ViewBuilder loadedBlock: (DataType) -> some View
    ) -> some View {
        switch self {
        case .loaded(let loaded):
            loadedBlock(loaded)
        case .loading:
            GenericLoadingView()
        case .error:
            GenericErrorView()
        }
    }
    
    public var currentValue: DataType? {
        switch self {
        case .loaded(let loaded): return loaded
        default: return nil
        }
    }
    
    public var errorValue: Error? {
        switch self {
        case .error(error: let error): return error
        default: return nil
        }
    }
}
