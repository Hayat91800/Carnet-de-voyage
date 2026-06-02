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
//            Text(date, format: .dateTime.day().month().year())
            AsyncImage(url: URL(string: "https://plus.unsplash.com/premium_photo-1697730075333-822144628df6?q=80&w=1035&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 220, height: 200)
            .clipShape(.rect(cornerRadius: 25))
            .shadow(color: .black.opacity(0.4), radius: 10, x:0, y:6)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .bottom) {
                Text("Marrakech")
                    .italic()
                    .font(.caption.bold())
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
            }
            }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
