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
    @Published var isPublic = true
    @Published var isArray = false
    @Published var generateTest = false
    @Published var addFetch = false
    @Published var snakeCase = false
    var testJson = ""
}

class SwiftNodeProperties:ObservableObject, Identifiable {
    let id = UUID()
    @Published var propertyName: String = ""
    @Published var propertyType: SwiftType = .String
    @Published var isOptional: Bool = false
    @Published var isVar: Bool = false
    @Published var hasCodingKey: Bool = false
    @Published var codingKey: String = ""
    @Published var dateFormat: String = ""
    @Published var childNode: SwiftNode?
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension String {
    var lowercasingFirst: String { prefix(1).lowercased() + dropFirst() }
    var uppercasingFirst: String { prefix(1).uppercased() + dropFirst() }

    var camelCased: String {
        guard !isEmpty else { return "" }
        let parts = components(separatedBy: .alphanumerics.inverted)
        let first = parts.first!.lowercasingFirst
        let rest = parts.dropFirst().map { $0.uppercasingFirst }

        return ([first] + rest).joined()
    }
}
