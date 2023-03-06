//
//  AppManager.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 24.02.23.
//

import Foundation
import SwiftUI

class AppManager: ObservableObject {
    @Published var swiftDocument: SwiftDocument
    @Published var swiftNode: SwiftNode
    init(swiftDocument: SwiftDocument) {
        self.swiftDocument = swiftDocument
        self.swiftNode = SwiftNode()
    }
}
