//
//  ContentView.swift
//  textTune
//
//  Created by Nazar Kapushchak on 3/18/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(username)
            
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $username)
            
            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
