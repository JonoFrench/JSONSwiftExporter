//
//  ContentView.swift
//  JSONClassExporter
//
//  Created by Jonathan French on 24.02.23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: JSONClassExporterDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(JSONClassExporterDocument()))
    }
}
