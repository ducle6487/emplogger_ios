//
//  Image+qrCode.swift
//  Base
//
//  Created by AnhDuc on 04/03/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

extension Image {
    public static func qrCode(from string: String) -> Image? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.setValue(Data(string.utf8), forKey: "inputMessage")
        // High level since we are overlaying a logo
        // ensures scanability even though we are covering parts
        filter.correctionLevel = "H"
        
        // Filter default white background so we can render our image as template
        let qr: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        let transparent: CIColor = CIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        let alphaFilter: CIFilter = CIFilter(name: "CIFalseColor")!
        alphaFilter.setDefaults()
        alphaFilter.setValue(filter.outputImage, forKey: "inputImage")
        alphaFilter.setValue(qr, forKey: "inputColor0")
        alphaFilter.setValue(transparent, forKey: "inputColor1")
        let alphaOutput = alphaFilter.outputImage
        guard let alphaOutput else { return nil }

        // Resolve our qr image to a SwiftUI image
        guard let cgimg = context.createCGImage(alphaOutput, from: alphaOutput.extent) else { return nil }
        return Image(uiImage: UIImage(cgImage: cgimg))
    }
    
    public static func generateQrCodeImage(codeString: String) -> Image? {

        let qrData = codeString.data(using: String.Encoding.ascii)
        
        // Get a QR CIFilter
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            else { return nil }
        
        // Input the data
        qrFilter.setValue(qrData, forKey: "inputMessage")
        
        // Get the output image
        guard let qrImage = qrFilter.outputImage else { return nil }
        
        // Scale the image
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledQrImage = qrImage.transformed(by: transform)
        
        let context = CIContext()
        guard let cgImage = context.createCGImage(scaledQrImage, from: scaledQrImage.extent) else { return nil }
        
        return Image(uiImage: UIImage(cgImage: cgImage))
    }
}
