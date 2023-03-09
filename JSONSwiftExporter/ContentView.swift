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
                    TextEditor(text: $document.text).multilineTextAlignment(.leading)
                        .font(Font.custom("Courier", size: 14).monospacedDigit())
                    Spacer()
                    Button("Parse JSON") {
                        if let filename = document.fileName {
                            print("Fliename \(filename)")
                            appManager.swiftNode.nodeName = filename.components(separatedBy:".")[0].capitalizingFirstLetter()
                        }
                        if (document.parseJSON(swiftClass: appManager.swiftNode)) {
                            appManager.swiftNode.testJson = document.text
                            appManager.swiftDocument.text = appManager.swiftNode.generateSwiftCode()
                            isParsed = true
                            isLoaded = true
                        } else {
                            print("Couldn't parse json")
                        }
                    }
                    Spacer()
                }
                Spacer()
                
                VStack {
                    Spacer()
                    if (isLoaded) {
                        SwiftNodeHeader(manager: appManager)
                        Text("Properties").font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        List {
                            ListNode(node: $appManager.swiftNode)
                        }
                    } else {
                        VStack {
                            HStack {
                                Text("Welcome to JSONSwiftExporter").foregroundColor(.white).font(.title)
                            }.background(.yellow)
                            Spacer()
                        }
                    }
                        Spacer()
                        Button("Regenerate Class") {
                            appManager.swiftNode.testJson = document.text
                            if (document.parseJSON(swiftClass: appManager.swiftNode)) {
                                appManager.swiftDocument.text = appManager.swiftNode.generateSwiftCode()
                                isParsed = true
                            } else {
                                isParsed = false
                                isLoaded = false
                            }
                        }.disabled(!isLoaded)
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        TextEditor(text: $appManager.swiftDocument.text).multilineTextAlignment(.leading)
                            .font(Font.custom("Courier", size: 14).monospacedDigit())
                        Spacer()
                        Button("Save Swift File") {
//                            appManager.swiftDocument.text = appManager.swiftNode.generateSwiftCode()
                            print("\(appManager.swiftNode.nodeName).swift")
                            appManager.swiftDocument.saveDoc(filename: "\(appManager.swiftNode.nodeName).swift")
                        }.disabled(!isParsed)
                        Spacer()
                    }
                }
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
