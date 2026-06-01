//
//  ContentView.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 01/06/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Carnet de Voyage de Hayat")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
