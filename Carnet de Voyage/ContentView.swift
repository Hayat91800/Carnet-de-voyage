//
//  ContentView.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 01/06/2026.
//

import SwiftUI

/// Onglets de l'app
enum Onglet: Hashable {
    case accueil, lieux, continents
}

struct ContentView: View {

    /// @State : la liste des lieux. Toute modification met l'interface à jour.
    @State private var visites = Visite.exemples
    @State private var ongletSelectionne: Onglet = .accueil

    var body: some View {
        TabView(selection: $ongletSelectionne) {
            AccueilView(visites: visites, ongletSelectionne: $ongletSelectionne)
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(Onglet.accueil)

            ListeLieuxView(visites: $visites)
                .tabItem { Label("Mes lieux", systemImage: "list.bullet") }
                .tag(Onglet.lieux)

            Continents(visites: $visites)
                .tabItem { Label("Continents", systemImage: "globe") }
                .tag(Onglet.continents)
        }
        .tint(.brown)
    }
}

/// Écran d'accueil : titre, progression et carrousel
struct AccueilView: View {

    let visites: [Visite]
    @Binding var ongletSelectionne: Onglet

    @State private var progressionAffichee: Double = 0

    private var nombreVisites: Int { visites.filter { $0.estVisite }.count }

    private var progression: Double {
        visites.isEmpty ? 0 : Double(nombreVisites) / Double(visites.count)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    Text("Venez découvrir avec moi ces incroyables destinations")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Suivi d'activité : part des lieux visités
                    VStack(spacing: 12) {
                        Text("Suivi d'activité")
                            .font(.headline)
                            .padding(10)
                            .background(.background.secondary)
                            .clipShape(.rect(cornerRadius: 10))

                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 15)

                            Circle()
                                .trim(from: 0, to: progressionAffichee)
                                .stroke(
                                    LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom),
                                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))

                            VStack(spacing: 2) {
                                Text("\(Int(progression * 100))%")
                                    .font(.largeTitle.bold())
                                    .monospacedDigit()
                                Text("\(nombreVisites) / \(visites.count) visités")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(width: 150, height: 150)
                    }
                    .onAppear {
                        withAnimation(.easeOut(duration: 1.5)) {
                            progressionAffichee = progression
                        }
                    }
                    .onChange(of: progression) { _, nouvelleValeur in
                        withAnimation { progressionAffichee = nouvelleValeur }
                    }

                    // Carrousel des lieux qui ont une photo
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(visites.filter { $0.image != nil }) { visite in
                                if let image = visite.image {
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 250, height: 250)
                                        .clipShape(.rect(cornerRadius: 25))
                                        .overlay(alignment: .bottom) {
                                            Text(visite.lieu)
                                                .italic()
                                                .font(.headline)
                                                .foregroundStyle(.white)
                                                .shadow(radius: 4)
                                                .padding()
                                        }
                                        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 6)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    }

                    Button {
                        ongletSelectionne = .lieux
                    } label: {
                        Label("Découvrir mes lieux", systemImage: "airplane.departure")
                            .font(.title3)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brown)
                }
                .padding(.vertical)
            }
            .navigationTitle("Carnet de Voyage")
        }
    }
}

#Preview {
    ContentView()
}
