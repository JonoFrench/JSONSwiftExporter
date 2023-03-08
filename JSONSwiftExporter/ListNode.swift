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
        
        ForEach($node.properties) { prop in
            if let child = prop.childNode {
                let b = Binding(child)
                if let c = b {
                    ListNode(node: c)
                }
            }
        }
    }
}

//struct ListNode_Previews: PreviewProvider {
//    static var previews: some View {
//        ListNode()
//    }
//}
