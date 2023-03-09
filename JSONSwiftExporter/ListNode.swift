//
//  ListNode.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 7.03.23.
//

import SwiftUI

struct ListNode: View {
    @Binding var node: SwiftNode
    var body: some View {
        ListNodeHeader(node: $node)
        ForEach($node.properties) { prop in
            SwiftNodeItem(property: prop)
        }
        /// This function requires a Binding on SwiftNode, now the properties can have an optional child SwiftNode
        /// so we have to change the optional to a non optional Bound variable to iterate the tree of child nodes.
        ForEach($node.properties) { property in
            if let boundChild = Binding(property.childNode) {
                ListNode(node: boundChild)
            }
        }
    }
}
