//
//  JSONSwiftExporterApp.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 24.02.23.
//

import SwiftUI

@main
struct JSONSwiftExporterApp: App {
    @StateObject private var manager = AppManager(swiftDocument: SwiftDocument())
    var body: some Scene {
        DocumentGroup(newDocument: JSONSwiftExporterDocument()) { file in
            ContentView(document: file.$document)//.environmentObject(manager)
        }
    }
}
