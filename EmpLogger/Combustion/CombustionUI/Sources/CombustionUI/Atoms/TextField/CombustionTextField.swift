//
//  CombustionTextField.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combine
import Combustion
import EmpLoggerCore
import EmpLoggerInjection

public struct CombustionTextField: View {
    public typealias CompletionCallback = (String) async -> (validity: Bool, error: String?)
    
    @EnvironmentObject private var theme: ThemeProvider
    
    @Binding private var inputText: String
    @State private var isInputValid: Bool = true
    @State private var errorMessage: String = ""
    @State private var inputSize = CGSize(width: 1, height: 1)
    
    private var placeholder: String
    private var returnStyle: SubmitLabel = .done
    private var keyboardStyle: KeyboardStyle
    private var onSubmit: (() -> Void)?
    private var font: Font
    
    /// Textfield coumponent that can be reused throughout the application.
    ///
    /// - Parameters:
    ///   - placeholder: A place holder text for the text field.
    ///   - type: `KeyboardType` to determine style of keyboard
    ///   - callback: `CompletionCallback` to respond to async events on textfield
    public init(
        inputText: Binding<String>,
        placeholder: String,
        keyboardStyle: KeyboardStyle,
        returnStyle: SubmitLabel,
        font: Font = .title2.bold(),
        onSubmit: (() -> Void)? = nil
    ) {
        self._inputText = inputText
        self.placeholder = placeholder
        self.keyboardStyle = keyboardStyle
        self.returnStyle = returnStyle
        self.onSubmit = onSubmit
        self.font = font
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.squishy) {
            ZStack {
                // Dummy text for getting width of textfield content
                ChildGeometryReader(size: $inputSize) {
                    Text(inputText.isEmpty ? placeholder : inputText)
                        .font(font)
                        .opacity(0)
                }
                
                // Actual text input
                TextField(placeholder, text: $inputText)
                    .font(font)
                    .foregroundColor(errorMessage.isEmpty ? theme.colors.primary : theme.colors.error)
                    .keyboardType(keyboardStyle.keyboardType)
                    .submitLabel(returnStyle)
                    .onSubmit { onSubmit?() }
                    .textFieldStyle(.plain)
                    .tint(theme.colors.primary)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(keyboardStyle.autoCapitalization)
                    .scaledToFit()
                    .frame(maxWidth: inputSize.width)
            }
        }
    }
}

// MARK: - Previews
struct CombustionTextField_Previews: PreviewProvider {
    struct Wrapper: View {
        @EnvironmentObject var theme: ThemeProvider
        @State var text: String = ""
        
        var body: some View {
            VStack {
                CombustionTextField(
                    inputText: $text,
                    placeholder: "Mobile number",
                    keyboardStyle: .phoneNumber,
                    returnStyle: .next
                )
                .roundedCell(theme.colors.surface)
            }
            .padding(theme.spacing.comfortable)
        }
    }
    
    static var previews: some View {
        Wrapper()
            .previewTheme(for: .light)
    }
}
