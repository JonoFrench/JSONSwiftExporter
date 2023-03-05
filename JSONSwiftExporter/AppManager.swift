//
//  AppManager.swift
//  JSONClassExporter
//
//  Created by Jonathan French on 24.02.23.
//

import Foundation
import SwiftUI

class AppManager: ObservableObject {
    //@EnvironmentObject var document: JSONClassExporterDocument
    @Published var swiftDocument: SwiftDocument
    @Published var swiftNode: SwiftNode
    init(swiftDocument: SwiftDocument) {
        //self.document = document
        self.swiftDocument = swiftDocument
        self.swiftNode = SwiftNode()
    }
}
