//
//  PDFKitView.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import PDFKit
import SwiftUI

public struct PDFKitView: UIViewRepresentable {
    let data: Data
    let pdfView = PDFView()
    
    public init(data: Data) {
        self.data = data
        self.pdfView.document = PDFDocument(data: data)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<PDFKitView>) -> PDFView {
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.setValue(true, forKey: "forcesTopAlignment")
        return pdfView
    }
    
    public func updateUIView(_ uiView: PDFView, context: UIViewRepresentableContext<PDFKitView>) {
        // we will leave this empty as we don't need to update the PDF
    }
}
