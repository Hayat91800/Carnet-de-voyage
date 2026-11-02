//
//  DetailsView.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 10/06/2026.
//
//  Écran "Détail" : la fiche d'un lieu au tap.
//

import SwiftUI

struct DetailsView: View {

    @Binding var visite: Visite

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Image (ou SF Symbol si pas de photo)
                ZStack(alignment: .bottomLeading) {
                    if let image = visite.image {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.brown.opacity(0.15))
                            .frame(height: 250)
                            .overlay {
                                Image(systemName: "photo")
                                    .font(.system(size: 60))
                                    .foregroundStyle(.brown)
                            }
                    }

                    Text(visite.statut)
                        .font(.caption.bold())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .foregroundStyle(.white)
                        .background(visite.estVisite ? Color.green : Color.orange)
                        .clipShape(Capsule())
                        .padding()
                }
                .clipShape(.rect(cornerRadius: 22))

                Text(visite.lieu)
                    .font(.largeTitle.bold())

                HStack(spacing: 16) {
                    Label(visite.pays, systemImage: "flag.fill")
                    Label(visite.ville, systemImage: "building.2.fill")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Label(visite.continent, systemImage: "globe.europe.africa.fill")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if !visite.description.isEmpty {
                    Text(visite.description)
                        .font(.body)
                }

                // Bonus : note
                VStack(alignment: .leading, spacing: 6) {
                    Text("Ma note")
                        .font(.headline)
                    Etoiles(note: $visite.note)
                        .font(.title2)
                }

                // Action : changer le statut
                Button {
                    withAnimation { visite.estVisite.toggle() }
                } label: {
                    Label(visite.estVisite ? "Marquer « à découvrir »" : "Marquer comme visité",
                          systemImage: visite.estVisite ? "arrow.uturn.backward.circle" : "checkmark.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(visite.estVisite ? Color.orange : Color.green)
            }
            .padding()
        }
        .navigationTitle(visite.ville)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var visite = Visite.exemples[0]
    NavigationStack {
        DetailsView(visite: $visite)
    }
}
