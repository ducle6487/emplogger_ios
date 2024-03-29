//
//  SingleAxisGeometryReader.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Foundation

public struct SingleAxisGeometryReader<Content: View>: View {
    @State private var size: CGFloat = SizeKey.defaultValue
    
    private struct SizeKey: PreferenceKey {
        static var defaultValue: CGFloat { 100 }
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }

    // MARK: Reader Defaults
    public var axis: Axis
    public var alignment: Alignment
    @ViewBuilder let content: (CGFloat) -> Content
    
    public init(
        axis: Axis = .horizontal,
        alignment: Alignment = .center,
        @ViewBuilder _ content: @escaping (CGFloat) -> Content
    ) {
        self.axis = axis
        self.alignment = alignment
        self.content = content
    }
    
    // MARK: - Content
    public var body: some View {
        content(size)
            .frame(
                maxWidth: axis == .horizontal ? .infinity : nil,
                maxHeight: axis == .vertical  ? .infinity : nil,
                alignment: alignment
            )
            // Using background restricts our geometry reader to being greedy only in the specified
            // .infinity dimension as determined above by frame.
            .background(GeometryReader { proxy in
                // Store our determined dimension in a preference for use up the viewstack
                Color.clear.preference(
                    key: SizeKey.self,
                    value: axis == .horizontal ? proxy.size.width : proxy.size.height
                )
            })
            // notify of the dimension change
            .onPreferenceChange(SizeKey.self) { size = $0 }
    }
}
