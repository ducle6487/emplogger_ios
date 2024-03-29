//
//  CombustionButton.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion
import EmpLoggerCore
import EmpLoggerInjection

public typealias ButtonAction = () -> Void

public struct CombustionButton: View {
    @EnvironmentObject private var theme: ThemeProvider
    @Inject(\.analytics) var analytics
    
    // MARK: - Instance Properties
    public var title: String
    public var isEnabled: Bool
    public var isLoading: Bool
    public var type: CombustionButtonType
    public var event: String?
    public var eventParameters: AnalyticsEventParameters
    public var wrapContent: Bool
    public var action: ButtonAction
    
    // MARK: - Button Lifecycle
        
    /// Custom round button
    ///
    /// Button component that can be reused throughout the application. Actions willl be completed
    /// in the onPress event of the button.
    ///
    /// - Parameters:
    ///   - title: Title text for button.
    ///   - type: `CombustionButtonType` to determine style of button
    ///   - event: Optional analytics event to trigger on interaction with the button
    ///   - eventParameters: Optional analytics event parameters to be set in event on interaction with the button button
    ///   - enabled: Optional binding of the enabled state of the button to the Store
    ///   - loading: Optional binding of the loading state of the button to the Store
    ///   - action: Action closure that will be triggered on click
    public init(
        title: String,
        type: CombustionButtonType = .primary,
        event: String? = nil,
        eventParameters: AnalyticsEventParameters = [:],
        enabled isEnabled: Bool = true,
        loading isLoading: Bool = false,
        wrapContent: Bool = false,
        action: @escaping ButtonAction
    ) {
        self.title = title
        self.type = type
        self.event = event
        self.eventParameters = eventParameters
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.wrapContent = wrapContent
        self.action = action
    }
    
    public var body: some View {
        // Forward button action closure to on click
        Button(action: {
            action()
            // Log our button interactions
            if let event { analytics.log(event: event, parameters: eventParameters) }
        }) {
            buttonBody
        }
        // Disable our button if it is loading aswell as disabled state
        .disabled(!isEnabled || isLoading)
    }
}

// MARK: - Stateful color properties
extension CombustionButton {
    var textColor: Color {
        type.textColor(for: theme, enabled: isEnabled)
    }
    
    var backgroundColor: Color {
        type.backgroundColor(for: theme, enabled: isEnabled)
    }
}

// MARK: - Button Content
extension CombustionButton {
    var buttonBody: some View {
        // Stack our content and progress bar so that our
        // content is centered
        // Using just an HStack here off centers the text
        // when a progress view is visible
        ZStack {
            Group {
                // If wrap content, set our width to the size of intrinsic content
                if wrapContent {
                    buttonContent
                } else {
                    // Otherwise our button should try fill space greedily
                    buttonContent
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(theme.spacing.comfortable)
            
            if isLoading {
                loadingStack
            }
        }
        .frame(minHeight: 54)
        .background(backgroundColor)
        .foregroundColor(textColor)
        .cornerRadius(theme.radius.large, antialiased: true)
    }
    
    var buttonContent: some View {
        Text(title)
            .font(.system(size: 17))
            .bold()
    }
    
    var loadingStack: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(
                    CircularProgressViewStyle(
                        tint: textColor
                    )
                )
                .padding(theme.spacing.comfortable)
        }
    }
}

// MARK: - Autoclosure convenience
extension CombustionButton {
    public init(
        title: String,
        type: CombustionButtonType = .primary,
        event: String? = nil,
        eventParameters: AnalyticsEventParameters = [:],
        enabled isEnabled: Bool = true,
        loading isLoading: Bool = false,
        wrapContent: Bool = false,
        action: @autoclosure @escaping ButtonAction
    ) {
        self.title = title
        self.type = type
        self.event = event
        self.eventParameters = eventParameters
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.wrapContent = wrapContent
        self.action = action
    }
}

// MARK: - Previews
struct CombustionButton_Previews: PreviewProvider {
    static var previews: some View {
        // MARK: Primary buttons
        VStack {
            CombustionButton(
                title: "Primary",
                enabled: true,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Primary loading",
                enabled: true,
                loading: true,
                action: {}
            )
            
            CombustionButton(
                title: "Primary disabled",
                enabled: false,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Primary disabled loading",
                enabled: false,
                loading: true,
                action: {}
            )
        }
        .padding()
        .previewTheme(for: .light)
            
        // MARK: Secondary buttons
        VStack {
            CombustionButton(
                title: "Secondary",
                type: .secondary,
                enabled: true,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Secondary loading",
                type: .secondary,
                enabled: true,
                loading: true,
                action: {}
            )
            
            CombustionButton(
                title: "Secondary disabled",
                type: .secondary,
                enabled: false,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Secondary disabled loading",
                type: .secondary,
                enabled: false,
                loading: true,
                action: {}
            )
        }
        .padding()
        .previewTheme(for: .light)
        
        // MARK: Ternary buttons
        VStack {
            CombustionButton(
                title: "Tertiary",
                type: .tertiary,
                enabled: true,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Tertiary loading",
                type: .tertiary,
                enabled: true,
                loading: true,
                action: {}
            )
            
            CombustionButton(
                title: "Tertiary disabled",
                type: .tertiary,
                enabled: false,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Tertiary disabled loading",
                type: .tertiary,
                enabled: false,
                loading: true,
                action: {}
            )
        }
        .padding()
        .previewTheme(for: .light)
        
        // MARK: Primary text only buttons
        VStack {
            CombustionButton(
                title: "Primary text only",
                type: .primaryTextOnly,
                enabled: true,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Primary text only disabled",
                type: .primaryTextOnly,
                enabled: false,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Primary text only loading",
                type: .primaryTextOnly,
                enabled: true,
                loading: true,
                action: {}
            )
        }
        .padding()
        .previewTheme(for: .light)
        
        // MARK: Secondary text only buttons
        VStack {
            CombustionButton(
                title: "Secondary text only",
                type: .secondaryTextOnly,
                enabled: true,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Secondary text only disabled",
                type: .secondaryTextOnly,
                enabled: false,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Secondary text only loading",
                type: .secondaryTextOnly,
                enabled: true,
                loading: true,
                action: {}
            )
        }
        .background(Color.blue)
        .padding()
        .previewTheme(for: .light)
        
        // MARK: Ternary text only buttons
        VStack {
            CombustionButton(
                title: "Tertiary text only",
                type: .tertiaryTextOnly,
                enabled: true,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Tertiary text only disabled",
                type: .tertiaryTextOnly,
                enabled: false,
                loading: false,
                action: {}
            )
            
            CombustionButton(
                title: "Tertiary text only loading",
                type: .tertiaryTextOnly,
                enabled: true,
                loading: true,
                action: {}
            )
        }
        .background(Color.blue)
        .padding()
        .previewTheme(for: .light)
    }
}
