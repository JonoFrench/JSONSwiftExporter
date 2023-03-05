//
//  SwiftClassHeader.swift
//  JSONClassExporter
//
//  Created by Jonathan French on 26.02.23.
//

import SwiftUI

struct SwiftClassHeader: View {
    @StateObject var manager: AppManager
    var body: some View {
        Spacer()
        VStack {
            HStack {
                Spacer()
                Text("Class Name").foregroundColor(.white).font(.title)
                TextField("Class Name", text: $manager.swiftNode.nodeName).font(.headline)
                Spacer()
            }
        }.background(.gray)
        Spacer()

    }
}

//struct SwiftClassHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftClassHeader(manager: AppManager(document: JSONClassExporterDocument(text: ""), swiftDocument: SwiftDocument(text: "")))
//    }
//}
