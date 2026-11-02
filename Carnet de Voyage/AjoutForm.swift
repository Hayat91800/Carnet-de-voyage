//
//  AjoutForm.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 10/06/2026.
//
//  Écran "Ajout" : un formulaire pour créer un lieu.
//

import SwiftUI

struct AjoutForm: View {

    var continentParDefaut = "Europe"
    var onAjout: (Visite) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var pays = ""
    @State private var ville = ""
    @State private var lieu = ""
    @State private var description = ""
    @State private var continentSelect = "Europe"
    @State private var estVisite = false
    @State private var note = 0

    private var formulaireValide: Bool {
        !pays.trimmingCharacters(in: .whitespaces).isEmpty
        && !ville.trimmingCharacters(in: .whitespaces).isEmpty
        && !lieu.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Lieu") {
                    TextField("Nom du lieu", text: $lieu)
                    TextField("Ville", text: $ville)
                    TextField("Pays", text: $pays)
                    Picker("Continent", selection: $continentSelect) {
                        ForEach(Continent.continent) { unContinent in
                            Text(unContinent.nom).tag(unContinent.nom)
                        }
                    }
                }

                Section("Description") {
                    TextField("Quelques mots sur ce lieu…", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }

                Section("Statut") {
                    Toggle("Déjà visité", isOn: $estVisite)
                    if estVisite {
                        HStack {
                            Text("Ma note")
                            Spacer()
                            Etoiles(note: $note)
                        }
                    }
                }
            }
            .navigationTitle("Nouveau lieu")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                continentSelect = continentParDefaut
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Annuler") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter") {
                        let nouvelleVisite = Visite(
                            continent: continentSelect,
                            pays: pays.trimmingCharacters(in: .whitespaces),
                            ville: ville.trimmingCharacters(in: .whitespaces),
                            lieu: lieu.trimmingCharacters(in: .whitespaces),
                            image: nil,
                            description: description,
                            estVisite: estVisite,
                            note: estVisite ? note : 0
                        )
                        onAjout(nouvelleVisite)
                        dismiss()
                    }
                    .disabled(!formulaireValide)
                }
            }
        }
    }
}

#Preview {
    AjoutForm(onAjout: { _ in })
}
