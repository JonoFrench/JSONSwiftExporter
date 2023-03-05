//
//  SwiftClass.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 26.02.23.
//

import Foundation
import SwiftUI

enum SwiftType: String, Decodable, CaseIterable, Identifiable {
    var id: SwiftType { self }
    
    case String,Int,Double,Date,Url,Bool,Array,Struct
    
    var simpleDescription: String {
        switch self {
        case .String: return "String"
        case .Int: return "Int"
        case .Double: return "Double"
        case .Date: return "Date"
        case .Url: return "URL"
        case .Bool: return "Bool"
        case .Array: return "Array"
        case .Struct: return "Struct"
        }
    }
}

class SwiftNode:ObservableObject, Identifiable {
    let id = UUID()
    @Published var nodeName: String = ""
    @Published var properties: [SwiftNodeProperties] = []
    @Published var childNodes: [SwiftNode] = []

    
    fileprivate func swiftHeader(_ swiftString: inout String) {
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let todaysDate = dateFormatter.string(from: date)
        swiftString += "//" + "\n"
        swiftString += "// \(nodeName).swift" + "\n"
        swiftString += "//" + "\n"
        swiftString += "// Generated by JSONSwiftExporter on \(todaysDate)" + "\n"
        swiftString += "//" + "\n\n"
        swiftString += "import Foundation" + "\n\n"
    }
    
    fileprivate func swiftStruct(_ swiftString: inout String, props: [SwiftNodeProperties]) {
        swiftString += "struct \(nodeName): Codable {" + "\n\n"
        props.forEach {
            swiftString += "\t\($0.isVar ? "var" : "let") \($0.hasCodingKey ? $0.codingKey : $0.propertyName): \($0.propertyType != .Array ? $0.propertyType.simpleDescription: "[" + $0.childNode!.nodeName + "]")\($0.isOptional ? "?" : "") " + "\n"
        }
        swiftCodingKeys(&swiftString)
        swiftString += "}" + "\n\n"

        props.forEach {
            
            if let child = $0.childNode {
                child.swiftStruct(&swiftString,props: child.properties)
            }
        }
    }
    
    fileprivate func swiftCodingKeys(_ swiftString: inout String) {
        swiftString += "\n\tenum CodingKeys: String, CodingKey {" + "\n"
        swiftString += "\tcase " //+ "\n\t"
        properties.forEach {
            swiftString += "\($0.hasCodingKey ? "" : $0.propertyName + ",") "
        }
        swiftString.removeLast(2)
        swiftString += "\t\n\n"
        properties.forEach {
            if $0.hasCodingKey {
                swiftString += "\tcase \($0.propertyName) = \"\($0.codingKey)\" \n"
            }
        }
        swiftString += "\t}" + "\n"
    }
    
    func generateSwiftCode() -> String {
        var swiftString = ""
        swiftHeader(&swiftString)
        
        swiftStruct(&swiftString,props: properties)
         return swiftString
    }
}

class SwiftNodeProperties:ObservableObject, Identifiable {
    let id = UUID()
    @Published var propertyName: String = ""
    @Published var propertySample: String = ""
    @Published var propertyType: SwiftType = .String
    @Published var isOptional: Bool = false
    @Published var isVar: Bool = false
    @Published var hasCodingKey: Bool = false
    @Published var codingKey: String = ""
    @Published var dateFormat: String = ""
    @Published var childNode: SwiftNode?
}

extension String {
    var isInt: Bool {
        return Int(self) != nil && self.count < 7
    }
}
extension String {
    var isDouble: Bool {
        if !self.contains(".") { return false }
        return Double(self) != nil
    }
}

extension String {
    var isBool: Bool {
        return self == "false" || self == "true"
    }
}

extension String {
    var isNull: Bool {
        return self == "" || self == "null"
    }
}

extension String {
    var isURL: Bool {
        return self.starts(with: "HTTP")
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
