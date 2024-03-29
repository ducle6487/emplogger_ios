//
//  RegistrationStep.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Graphics
import Foundation
import Combustion
import EmpLoggerInjection

public struct RegistrationStep<Content: View>: View {
    @Namespace var fallbackNamespace
    @Environment(\.registrationNamespace) var matchedNamespace
    var namespace: Namespace.ID {
        matchedNamespace ?? fallbackNamespace
    }

    @InjectObservable(\.keyboardStore) var keyboardStore
    @EnvironmentObject private var theme: ThemeProvider

    public var id: UUID = UUID()
    public var primaryButton: CombustionButton
    public var secondaryButton: CombustionButton?
    public var tertiaryButton: CombustionButton?
    public var headerButton: CombustionButton?
    public var footerLogo: Image?
    public var footerBgImg: Image?
    let content: Content

    @State private var footerSize = CGSize(width: 1, height: 1)

    public init(
        primaryButton: CombustionButton,
        secondaryButton: CombustionButton? = nil,
        tertiaryButton: CombustionButton? = nil,
        headerButton: CombustionButton? = nil,
        footerLogo: Image? = nil,
        footerBgImg: Image? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.tertiaryButton = tertiaryButton
        self.headerButton = headerButton
        self.footerLogo = footerLogo
        self.footerBgImg = footerBgImg
        self.content = content()
    }

    public var body: some View {
        ZStack {
            theme.colors.primary
                .opacity(0.2)
                .ignoresSafeArea()

            background

            stepContent
                .padding(theme.spacing.comfortable)
                .foregroundColor(theme.colors.onBackground)
        }
        .fullSizeTopLayout()
    }

    var background: some View {
        ZStack(alignment: .bottom) {
            ChildGeometryReader(size: $footerSize) {
                VStack {
                    footerLogo?
                        .padding(.bottom, theme.spacing.cozy)
                    footerBgImg?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, theme.spacing.cozy)
            .ignoresSafeArea()

            // Fill our zstack
            Color.clear.ignoresSafeArea()

            Group { tertiaryButton }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(maxHeight: theme.spacing.roomy)
                }
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

extension RegistrationStep {
    var stepContent: some View {
        VStack(alignment: .leading, spacing: theme.spacing.cozy) {
            Spacer()
                .matchedGeometryEffect(id: "top-spacer", in: namespace)

            content.matchedGeometryEffect(id: "content", in: namespace)
            Spacer().matchedGeometryEffect(id: "middle-spacer", in: namespace)
            Group {
                secondaryButton.matchedGeometryEffect(id: "secondary-button", in: namespace)
                primaryButton.matchedGeometryEffect(id: "primary-button", in: namespace)

                // Only pad extra when keyboard isnt open
                // this displays the buttons above the image
                // when keyboard is active, the safe area will push the buttons up
                if !keyboardStore.keyboardVisible {
                    Spacer().frame(height: footerSize.height)
                }
            }
            // Remove animation for closing keyboard
            .transaction { t in
                guard !keyboardStore.keyboardVisible else { return }
                t.animation = nil
            }
        }
        .frame(maxHeight: .infinity)
    }
}

// MARK: - Previews
struct RegistrationStep_Previews: PreviewProvider, DependencyMocker {
    struct Wrapper: View {
        @EnvironmentObject var theme: ThemeProvider
        @State var text: String = ""

        var body: some View {
            VStack {
                RegistrationStep(
                    primaryButton: CombustionButton(
                        title: "Next",
                        action: {}
                    ),
                    secondaryButton: CombustionButton(
                        title: "I'd rather complete registration later",
                        type: .primaryTextOnly,
                        action: {}
                    ),
                    tertiaryButton: CombustionButton(
                        title: "Having trouble? Resend email",
                        type: .primaryTextOnly,
                        action: {}
                    ),
                    footerLogo: nil,
                    footerBgImg: nil
                ) {
                    VStack(alignment: .leading, spacing: theme.spacing.cozy) {
                        Text("Please enter your mobile number")
                            .font(.title2)

                        CombustionTextField(
                            inputText: $text,
                            placeholder: "Mobile number",
                            keyboardStyle: .phoneNumber,
                            returnStyle: .next
                        )
                    }
                }
            }
        }
    }

    static var previews: some View {
        Wrapper()
            .previewTheme(for: .light)
    }
}
