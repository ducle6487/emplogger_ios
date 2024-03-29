//
//  HalfSheetView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

struct HalfSheetView<Content: View>: View {
    @EnvironmentObject private var theme: ThemeProvider
    @State private var contentSize: CGSize = CGSize(width: 1, height: 1)
    @GestureState private var dragged: CGFloat = 0
    private var maxDragBigger: CGFloat = 30
    @Binding var isPresented: Bool
    var onDismiss: () -> Void
    var content: Content
    
    init(
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // background greyed behind sheet
            Color.black
                .allowsHitTesting(isPresented)
                .opacity(isPresented ? 0.2 : 0)
                .animation(theme.motion.easeInOutMedium, value: isPresented)
                .onTapGesture {
                    // Close sheet on tap outside and trigger dismiss
                    onDismiss()
                    isPresented = false
                }
            
            // Put a background color at the bottom so it doesnt reveal content when the offset is animated
            // Only for devices that do not have a safe area at the bottom for color to extend into
            theme.colors.background
                .frame(maxWidth: .infinity, maxHeight: 50)
                .opacity(isPresented ? 1 : 0)
                .animation(theme.motion.easeInOutMedium, value: isPresented)
            
            // Transalte our sheet based on presentation state
            sheet
                .offset(y: max(offset + dragged, -maxDragBigger))
                .animation(theme.motion.easeInOutMedium, value: isPresented)
                .animation(theme.motion.easeInOutMedium, value: dragged)
                .animation(theme.motion.easeInOutMedium, value: offset)
                .gesture(
                    DragGesture().updating($dragged) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        // User must drag more than a quarter to dismiss
                        guard value.translation.height > contentSize.height / 4 else { return }
                        onDismiss()
                        self.isPresented = false
                    }
                )
        }
        .ignoresSafeArea()
    }
    
    var offset: CGFloat {
        // Offset by at least 600 (avoid a jumping bug when content size changes)
        isPresented ? 0 : max(contentSize.height, 600)
    }
}

extension HalfSheetView {
    var sheet: some View {
        content
            .frame(maxWidth: .infinity)
            .background(
                ChildGeometryReader(size: $contentSize) {
                    Color.clear.ignoresSafeArea()
                }
            )
            .background(theme.colors.background)
            .cornerRadius(theme.radius.extraLarge, corners: [.topLeft, .topRight])
            .background(
                theme.colors.background
                    .ignoresSafeArea()
                    // Leave space for rounded corners on parent clipping
                    .padding(.top, theme.spacing.comfortable)
            )
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(maxHeight: theme.spacing.comfortable)
            }
    }
}

struct HalfSheetView_Previews: PreviewProvider {
    struct Wrapper: View {
        @State var isPresented: Bool = false
        
        var body: some View {
            ZStack {
                Button(action: {
                    isPresented.toggle()
                }) {
                    Text("Click me")
                }
                
                HalfSheetView(isPresented: $isPresented, onDismiss: {}) {
                    Text("Some content")
                        .frame(height: 300)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    static var previews: some View {
        Wrapper()
            .previewTheme(for: .light)
    }
}
