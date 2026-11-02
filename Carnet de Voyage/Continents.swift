//
//  Continents.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 04/06/2026.
//

import SwiftUI

/// Grille des continents → liste des lieux du continent
struct Continents: View {

    @Binding var visites: [Visite]

    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Continent.continent) { continent in
                        NavigationLink {
                            Pays(nomContinent: continent.nom, visites: $visites)
                        } label: {
                            VStack(spacing: 8) {
                                Image(continent.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())

                                Text(continent.nom)
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                    .italic()
                                    .multilineTextAlignment(.center)

                                Text("\(nombreDeLieux(continent.nom)) lieu(x)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Continents")
        }
    }

    private func nombreDeLieux(_ continent: String) -> Int {
        visites.filter { $0.continent == continent }.count
    }
}

#Preview {
    @Previewable @State var visites = Visite.exemples
    Continents(visites: $visites)
}
