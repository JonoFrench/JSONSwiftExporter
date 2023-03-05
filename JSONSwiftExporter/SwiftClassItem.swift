//
//  SwiftClassItem.swift
//  JSONClassExporter
//
//  Created by Jonathan French on 26.02.23.
//

import SwiftUI

struct SwiftClassItem: View {
    @State var manager: AppManager
    @Binding var property: SwiftNodeProperties
    
    var body: some View {
        Spacer()
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(property.propertyName).foregroundColor(.white)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                TextField("Property Name", text: $property.propertyName)
//                    .background(.white)
//                    .border(.black)
//                    .padding(.trailing)
//                    .frame(height: 48)
//                    .disabled(true)
                Spacer()
            }.frame(height: 48)
            Spacer()
            HStack {
                Spacer()
                Picker(selection: $property.propertyType, label: Text("Type")) {
                    ForEach (SwiftType.allCases, id: \.self) { sType in
                        Text(sType.rawValue)
                        Divider()
                    }
                }
                .padding(.trailing)
                .pickerStyle(.menu)
                    .foregroundColor(.white)

                Spacer()
            }
            HStack {
                Spacer()
                Toggle("Optional", isOn: $property.isOptional)
                    .foregroundColor(.white)
                Spacer()
                Toggle("Var", isOn: $property.isVar)
                    .foregroundColor(.white)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Toggle("Coding Key", isOn: $property.hasCodingKey)
                    .foregroundColor(.white)
                Spacer()
                //if property.hasCodingKey {
                    TextField("Key Name", text: $property.codingKey)
                        .foregroundColor(.black)
                        .background(.white)
                        .border(.black)
                        .padding(.trailing)
                        .disabled(!property.hasCodingKey)

                //}
                Spacer()

            }
            Spacer()
            
        }.background(.gray)
       // Spacer()
    }
}

//struct SwiftClassItem_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftClassItem(manager: AppManager(document: JSONClassExporterDocument(text: ""), swiftDocument: SwiftDocument(text: "")))
//    }
//}
