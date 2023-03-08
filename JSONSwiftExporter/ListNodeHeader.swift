//
//  ListNodeHeader.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 8.03.23.
//

import SwiftUI

struct ListNodeHeader: View {
    @Binding var node: SwiftNode
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Node Name").foregroundColor(.white).font(.title)
                TextField("Node Name", text: $node.nodeName).font(.headline)
            }
        }.background(.blue)
        
    }
}

//struct ListNodeHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ListNodeHeader()
//    }
//}
