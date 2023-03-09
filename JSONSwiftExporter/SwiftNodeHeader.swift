//
//  SwiftClassHeader.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 26.02.23.
//

import SwiftUI

struct SwiftNodeHeader: View {
    @StateObject var manager: AppManager
    var body: some View {
        Spacer()
        VStack {
            HStack {
                Spacer()
                Text("Node Name").foregroundColor(.white).font(.title)
                TextField("Node Name", text: $manager.swiftNode.nodeName).font(.headline)
                Spacer()
            }
        }.background(.gray)
        HStack {
            Toggle("public", isOn: $manager.swiftNode.isPublic)
                .foregroundColor(.black)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Toggle("Convert from snake_case", isOn: $manager.swiftNode.snakeCase)
                .foregroundColor(.black)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        Spacer()
        HStack {
            Toggle("Add fetch request", isOn: $manager.swiftNode.addFetch)
                .foregroundColor(.black)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Toggle("Add playground code", isOn: $manager.swiftNode.generateTest)
                .foregroundColor(.black)
                .padding(.trailing)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }

    }
}

//struct SwiftClassHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftClassHeader(manager: AppManager(document: JSONSwiftExporterDocument(text: ""), swiftDocument: SwiftDocument(text: "")))
//    }
//}
