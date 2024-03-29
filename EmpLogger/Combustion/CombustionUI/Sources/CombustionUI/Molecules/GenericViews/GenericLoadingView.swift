//
//  GenericLoadingView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI
import Combustion

public struct GenericLoadingView: View {
    public enum PlaceholderStyle {
        case cells(_ amount: Int)
        case group(_ anountOfCells: Int)
    }
    
    @EnvironmentObject var theme: ThemeProvider
    
    var placeholderStyle: PlaceholderStyle = .cells(1)
    
    public init(_ placeholderStyle: PlaceholderStyle = .cells(1)) {
        self.placeholderStyle = placeholderStyle
    }
    
    public var body: some View {
        CombustionList {
            switch placeholderStyle {
            case .cells(let amount):
                CombustionListSection {
                    ForEach(0 ..< amount, id: \.self) { _ in
                        CombustionListItem { placeholderCell }
                    }
                }
            case .group(let amount):
                CombustionListSection(headerInside: true) {
                    PlaceholderText(font: .body, width: 60)
                } content: {
                    ForEach(0 ..< amount, id: \.self) { _ in
                        CombustionListItem { placeholderCell }
                    }
                }
            }
        }
        .shimmering()
    }
    
    private var placeholderCell: some View {
        HStack(spacing: theme.spacing.cozy) {
            RoundedRectangle(cornerRadius: theme.radius.large)
                .foregroundColor(theme.colors.background)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: theme.spacing.squishy) {
                PlaceholderText(font: .body, width: 150)
                PlaceholderText(font: .caption, width: 215)
            }
        }
    }
}

struct GenericLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            GenericLoadingView(.cells(5))
        }
        .previewTheme(for: .light)
    }
}
