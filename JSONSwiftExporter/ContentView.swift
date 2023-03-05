//
//  ContentView.swift
//  JSONSwiftExporter
//
//  Created by Jonathan French on 24.02.23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: JSONSwiftExporterDocument
    @StateObject private var appManager = AppManager(swiftDocument: SwiftDocument())

    @State var isLoaded = false
    @State var isParsed = false
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                VStack {
                    Spacer()
                    TextEditor(text: $document.text)
                    Spacer()
                    Button("Parse JSON") {
                        if let filename = document.fileName {
                            print("Fliename \(filename)")
                            appManager.swiftNode.nodeName = filename.components(separatedBy:".")[0].capitalizingFirstLetter()
                        }
                        //manager.swiftDocument.text = document.getDictionary().description
                        document.parseJSONData(swiftClass: appManager.swiftNode)
                        appManager.swiftDocument.text = appManager.swiftNode.generateSwiftCode()
                        isParsed = true
                        isLoaded = true
                    }
                    Spacer()
                }
                Spacer()

                VStack {
                    SwiftClassHeader(manager: appManager)
                    Spacer()
                    if (isLoaded) {
                        Text("Properties").font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    List {
                        ForEach($appManager.swiftNode.properties) { prop in
                            SwiftClassItem(manager: appManager, property: prop)
//                            ForEach(prop.childProperties) { prop2 in
//                                    SwiftClassItem(manager: manager, property: prop2)
//                                }
                        }.background(.background)
                    }.padding(0)
                    Spacer()
                    Button("Regenerate Class") {
                        appManager.swiftDocument.text = appManager.swiftNode.generateSwiftCode()
                        isParsed = true
                    }.disabled(!isLoaded)
                    Spacer()

                }
                Spacer()
                VStack {
                    TextEditor(text: $appManager.swiftDocument.text).multilineTextAlignment(.leading)
                        .font(Font.custom("Courier", size: 14).monospacedDigit())
                    Spacer()
                    Button("Save Swift File") {
                        appManager.swiftDocument.text = appManager.swiftNode.generateSwiftCode()
                    }.disabled(!isParsed)
                    Spacer()
                }
            }
//            HStack{
//                Spacer()
//                Button("Generate Class") {
//                    manager.swiftDocument.text = manager.swiftClass.generateSwiftCode()
//                }
//                Spacer()
//            }
            Spacer()
        }.onAppear{
            //manager = AppManager(swiftDocument: SwiftDocument(text: ""))
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    //@EnvironmentObject var manager: AppManager
//    static var previews: some View {
//        ContentView()
//    }
//}
