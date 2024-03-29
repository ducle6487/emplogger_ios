//
//  File.swift
//  
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Graphics
import Combustion

public struct GenericErrorView: View {
    @EnvironmentObject var theme: ThemeProvider
    
    public enum ErrorType {
        case error(Error)
        case errorMessage(String)
        
        var description: String {
            switch self {
            case .errorMessage(let message):
                return message
            case .error(let error):
                return error.localizedDescription
            }
        }
    }
    
    var error: ErrorType
    var errorTitle: String
    var action: String?
    var button: CombustionButton?
    var image: CombustionImage
    
    public init(
        image: Image,
        error: ErrorType? = nil,
        errorTitle: String? = nil,
        button: CombustionButton? = nil
    ) {
        self.init(image: image.combustionImage(), error: error, errorTitle: errorTitle, button: button)
    }
    
    public init(
        image: CombustionImage? = nil,
        error: ErrorType? = nil,
        errorTitle: String? = nil,
        button: CombustionButton? = nil
    ) {
        self.error = error ?? .errorMessage("Something went wrong. Please try again later.")
        self.errorTitle = errorTitle ?? "Oops!"
        self.button = button
        self.image = image ?? CombustionImages.Placeholders.genericError.combustionImage()
    }
    
    public var body: some View {
        GenericModuleView(title: errorTitle, description: error.description, button: button, image: image)
    }
}

struct GenericErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            VStack {
                GenericErrorView(button: CombustionButton(title: "Refresh") { })
                GenericErrorView(
                    error: .errorMessage("Turn back on your internet and try again"),
                    errorTitle: "No internet connection"
                )
            }
        }
        .previewTheme(for: .light)
    }
}
