//
//  ListeLieuxView.swift
//  Carnet de Voyage
//
//  Écran "Liste" : tous les lieux (nom, pays, statut).
//

import SwiftUI

struct ListeLieuxView: View {

    @Binding var visites: [Visite]

    @State private var filtre: FiltreStatut = .tous
    @State private var showAjout = false

    private var lieuxFiltres: [Visite] {
        switch filtre {
        case .tous: return visites
        case .visites: return visites.filter { $0.estVisite }
        case .aDecouvrir: return visites.filter { !$0.estVisite }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Filtre", selection: $filtre) {
                        ForEach(FiltreStatut.allCases, id: \.self) { statut in
                            Text(statut.rawValue).tag(statut)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                }

                Section("\(lieuxFiltres.count) lieu(x)") {
                    ForEach(lieuxFiltres) { visite in
                        HStack(spacing: 12) {
                            // Bouton pour cocher / décocher "visité"
                            Button {
                                withAnimation { basculerStatut(visite) }
                            } label: {
                                Image(systemName: visite.estVisite ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                                    .foregroundStyle(visite.estVisite ? Color.green : Color.gray)
                            }
                            .buttonStyle(.borderless)

                            NavigationLink {
                                DetailsView(visite: binding(pour: visite))
                            } label: {
                                LigneLieu(visite: visite)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation { supprimer(visite) }
                            } label: {
                                Label("Supprimer", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Mes lieux")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAjout = true
                    } label: {
                        Label("Ajouter un lieu", systemImage: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $showAjout) {
                AjoutForm { nouvelleVisite in
                    visites.append(nouvelleVisite)
                }
            }
            .overlay {
                if lieuxFiltres.isEmpty {
                    ContentUnavailableView("Aucun lieu", systemImage: "map", description: Text("Ajoutez un lieu avec le bouton +."))
                }
            }
        }
    }

    // MARK: - Actions

    private func basculerStatut(_ visite: Visite) {
        if let index = visites.firstIndex(where: { $0.id == visite.id }) {
            visites[index].estVisite.toggle()
        }
    }

    private func supprimer(_ visite: Visite) {
        visites.removeAll { $0.id == visite.id }
    }

    /// Binding vers un lieu du tableau, pour pouvoir le modifier depuis la fiche détail
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

/// Une ligne de la liste : image, nom, pays et statut
struct LigneLieu: View {
    let visite: Visite

    var body: some View {
        HStack(spacing: 12) {
            ImageLieu(image: visite.image, taille: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(visite.lieu)
                    .font(.headline)

                Text("\(visite.pays) · \(visite.ville)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(visite.statut)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .foregroundStyle(visite.estVisite ? Color.green : Color.orange)
                    .background((visite.estVisite ? Color.green : Color.orange).opacity(0.15))
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    @Previewable @State var visites = Visite.exemples
    ListeLieuxView(visites: $visites)
}
