//
//  CombustionImage.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import Foundation

import SwiftUI
import Combustion

public struct CombustionImage: View {

    var image: Image
    var color: Color?
    var isResizable: Bool
    var isTwoToned: Bool

    init(
        image: Image,
        color: Color? = ColorTokens.Blacks.emploggerBlack60,
        resizable: Bool,
        twoToned: Bool = false
    ) {
        self.image = image
        self.color = color
        isResizable = resizable
        isTwoToned = twoToned
    }

    public var body: some View {
        if isTwoToned { combustionImage } else { singleTonedImage }
    }

    var singleTonedImage: some View {
        image
            .resizable(isResizable)
            .foregroundStyle(color)
    }

    var combustionImage: some View {
        ZStack {
            image
                .resizable(isResizable)
                .foregroundStyle(color)

            image
                .renderingMode(.template)
                .resizable(isResizable)
                .foregroundStyle(color)
                .blendMode(.overlay)
        }
    }

    public func resizable() -> CombustionImage {
        CombustionImage(image: image, color: color, resizable: true, twoToned: isTwoToned)
    }

    public func foregroundStyle(_ color: Color?) -> CombustionImage {
        CombustionImage(image: image, color: color, resizable: isResizable, twoToned: isTwoToned)
    }

    public func twoToned() -> CombustionImage {
        CombustionImage(image: image, color: color, resizable: isResizable, twoToned: true)
    }
}

extension Image {
    @ViewBuilder
    public func combustionImage() -> CombustionImage {
        CombustionImage(image: self, resizable: false)
    }
}

extension Image {
    func resizable(_ isResizable: Bool) -> Image {
        if isResizable { self.resizable() } else { self }
    }

    @ViewBuilder
    func foregroundStyle(_ color: Color?) -> some View {
        if let color { self.foregroundStyle(color) } else { self }
    }
}

// MARK: - Previews
struct CombustionImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Icons.System.share.combustionImage()
                .foregroundStyle(ColorTokens.Blues.emploggerBlue)
                .resizable().frame(width: 30, height: 30)
        }
    }
}
