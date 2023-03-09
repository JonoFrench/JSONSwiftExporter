//
//  JSONSwiftExporterDocument.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 24.02.23.
//

import SwiftUI
import UniformTypeIdentifiers


struct SwiftDocument: FileDocument {
    var text: String

    init(text: String = "//") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.exampleText,.jsonText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
    
    func saveDoc(filename: String) {
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = filename
        savePanel.allowedContentTypes = [.swiftSource]
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        savePanel.begin { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                
                if let saveURL = savePanel.url {
                    try? self.text.write(to: saveURL, atomically: true, encoding: .utf8)
                }
                
            }
        }
    }
}
