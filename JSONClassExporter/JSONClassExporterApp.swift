//
//  JSONClassExporterApp.swift
//  JSONClassExporter
//
//  Created by Jonathan French on 24.02.23.
//

import SwiftUI

@main
struct JSONClassExporterApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: JSONClassExporterDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
