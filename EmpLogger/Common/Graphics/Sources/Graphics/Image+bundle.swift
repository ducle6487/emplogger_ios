//
//  Image+bundle.swift
//
//
//  Created by AnhDuc on 05/03/2024.
//

import SwiftUI

extension Image {
    init(_ resource: String) {
        self.init(resource, bundle: Bundle.module)
    }
}
