//
//  Pays.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 07/06/2026.
//

import SwiftUI

/// Lieux d'un continent, regroupés par pays
struct Pays: View {

    var nomContinent: String
    @Binding var visites: [Visite]

    @State private var ajout = false

    private var visitesDuContinent: [Visite] {
        visites.filter { $0.continent == nomContinent }
    }

    /// Liste des pays du continent, sans doublon, dans l'ordre d'apparition
    private var paysDuContinent: [String] {
        var resultat: [String] = []
        for visite in visitesDuContinent where !resultat.contains(visite.pays) {
            resultat.append(visite.pays)
        }
        return resultat
    }

    var body: some View {
        List {
            ForEach(paysDuContinent, id: \.self) { pays in
                Section(pays) {
                    ForEach(visitesDuContinent.filter { $0.pays == pays }) { uneVisite in
                        NavigationLink {
                            DetailsView(visite: binding(pour: uneVisite))
                        } label: {
                            LigneLieu(visite: uneVisite)
                        }
                    }
                }
            }
        }
        .overlay {
            if visitesDuContinent.isEmpty {
                ContentUnavailableView("Aucun lieu", systemImage: "airplane", description: Text("Aucun lieu enregistré sur ce continent pour l'instant."))
            }
        }
        .navigationTitle(nomContinent)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    ajout = true
                } label: {
                    Label("Ajouter un lieu", systemImage: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $ajout) {
            AjoutForm(continentParDefaut: nomContinent) { nouvelleVisite in
                visites.append(nouvelleVisite)
            }
            .presentationDetents([.medium, .large])
        }
    }

    private func binding(pour visite: Visite) -> Binding<Visite> {
        Binding(
            get: { visites.first(where: { $0.id == visite.id }) ?? visite },
            set: { nouvelleValeur in
                if let index = visites.firstIndex(where: { $0.id == nouvelleValeur.id }) {
                    visites[index] = nouvelleValeur
                }
            }
        )
    }
}

#Preview {
    @Previewable @State var visites = Visite.exemples
    NavigationStack {
        Pays(nomContinent: "Europe", visites: $visites)
    }
}
