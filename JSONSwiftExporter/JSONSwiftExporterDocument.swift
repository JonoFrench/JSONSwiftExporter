//
//  JSONSwiftExporterDocument.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 24.02.23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleText: UTType {
        UTType(importedAs: "com.example.plain-text")
    }
}

extension UTType {
    static var jsonText: UTType {
        UTType(importedAs: "com.jaypeeff.json")
    }
}


struct JSONSwiftExporterDocument: FileDocument {
    var text: String
    var fileName: String?

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.exampleText,.jsonText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        fileName = configuration.file.filename
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
    
    func parseJSONData(swiftClass: SwiftNode) {
        var returnProperties: [SwiftNodeProperties] = []
        let data = Data(text.utf8)
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
            for jKey in json.keys {
                if let keyData = json[jKey] {
                    let returnProp = SwiftNodeProperties()
                    print("Key \(jKey) \(type(of: keyData)) ")
                    returnProp.propertyName = jKey
                    returnProp.codingKey = jKey
                    
                    returnProperties.append(match(keyData,properties: returnProp,swiftClass: swiftClass))
                }
            }
            swiftClass.properties = returnProperties
        }
    }
    
    func match(_ value: Any?, properties: SwiftNodeProperties,swiftClass: SwiftNode) -> SwiftNodeProperties {
        guard let value = value else {
            print("nil")
            properties.propertyType = .String
            properties.isOptional = true
            return properties
        }
        
        switch value {
        case let v as Bool:
            properties.propertyType = .Bool
            print("Bool \(v)")
        case let v as Int:
            properties.propertyType = .Int
            print("Int \(v)")
        case let v as Double:
            properties.propertyType = .Double
            print("Double \(v)")
        case let v as String:
            properties.propertyType = .String
            print("String \(v)")
        case let elements as [Any?]:
            print("Array with \(elements.count) values")
            properties.propertyType = .Array
            let newNode = SwiftNode()
            newNode.nodeName = properties.propertyName
            let data = elements[0] as! Dictionary<String, Any?>
                for jKey in data.keys {
                    if let keyData = data[jKey] {
                        print("Array element[\(data) ", terminator: "")
                        let returnProp = SwiftNodeProperties()
                        returnProp.propertyName = jKey
                        returnProp.codingKey = jKey
                        newNode.properties.append(match(keyData,properties:returnProp,swiftClass: swiftClass))
                    }
                }
            properties.childNode = newNode

        case let elements as [String: Any?]:
            properties.propertyType = .Array
            print("Dictionary with \(elements.count) values")
            let newNode = SwiftNode()
            let newStruct = elements.first
            newNode.nodeName = newStruct!.key
           let data = newStruct!.value as! [Any?]
            let dataDic = data[0] as! Dictionary<String, Any?>
            for jKey in dataDic.keys {
                if let keyData = dataDic[jKey] {
                    let returnProp = SwiftNodeProperties()
                    returnProp.propertyName = jKey
                    returnProp.codingKey = jKey
                    newNode.properties.append(match(keyData,properties:returnProp,swiftClass: newNode))
                }
            }
            properties.childNode = newNode
        default:
            properties.propertyType = .String
            properties.isOptional = true
        }
        return properties
    }
    
    func getDictionary() -> [String:Any] {
        let data = Data(text.utf8)
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
            for jKey in json.keys {
                if let keyData = json[jKey] {
                    print("Key \(jKey) \(type(of: keyData)) ")
                }
            }
            return json
        }
        return [:]
    }
}
