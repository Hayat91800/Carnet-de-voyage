//
//  Data.swift
//  Carnet de Voyage
//
//  Created by apprenant144 on 03/06/2026.
//

import SwiftUI

/// Un lieu du carnet : visité ou à découvrir
struct Visite: Identifiable {
    let id = UUID()
    var continent: String
    var pays: String
    var ville: String
    var lieu: String
    var image: ImageResource?        // nil = pas de photo, on affiche un SF Symbol
    var description: String
    var estVisite: Bool = false      // statut : visité / à découvrir
    var note: Int = 0                // bonus : note de 0 à 5 étoiles

    var statut: String { estVisite ? "Visité" : "À découvrir" }

    static let exemples: [Visite] = [
        Visite(continent: "Afrique", pays: "Maroc", ville: "Marrakech", lieu: "Koutoubia", image: .koutoubia,
               description: "Le plus grand minaret de Marrakech, chef-d'œuvre de l'architecture almohade, qui sert de point de repère visuel et spirituel à toute la ville.",
               estVisite: true, note: 5),
        Visite(continent: "Afrique", pays: "Maroc", ville: "Marrakech", lieu: "Jemaa El Fna", image: .jemaaelfna,
               description: "Le cœur battant et animé de la médina, célèbre pour ses conteurs, ses musiciens, ses charmeurs de serpents et ses étals de street-food à la nuit tombée.",
               estVisite: true, note: 4),
        Visite(continent: "Afrique", pays: "Maroc", ville: "Marrakech", lieu: "Souk", image: .souk,
               description: "Un labyrinthe vibrant de ruelles commerçantes où s'entremêlent les parfums d'épices, l'artisanat traditionnel (cuir, tapis, poterie) et le savoir-faire des artisans locaux.",
               estVisite: true, note: 4),
        Visite(continent: "Afrique", pays: "Maroc", ville: "Marrakech", lieu: "Palais Bahia", image: .bahia,
               description: "Un chef-d'œuvre architectural du XIXe siècle, réputé pour ses plafonds peints, ses stucs ciselés et ses magnifiques patios arborés qui illustrent le faste de l'art marocain et islamique."),
        Visite(continent: "Amérique du Nord", pays: "États-Unis", ville: "New York", lieu: "Statue de la Liberté", image: nil,
               description: "Située sur Liberty Island, ce cadeau de la France aux États-Unis est le symbole universel de la liberté, de la démocratie et de l'accueil des immigrants."),
        Visite(continent: "Amérique du Nord", pays: "États-Unis", ville: "New York", lieu: "Empire State Building", image: nil,
               description: "Un gratte-ciel de style Art déco légendaire situé à Manhattan, offrant depuis ses observatoires une vue panoramique spectaculaire sur toute la mégapole."),
        Visite(continent: "Amérique du Nord", pays: "États-Unis", ville: "New York", lieu: "Central Park", image: nil,
               description: "Un immense et verdoyant poumon vert de 341 hectares en plein cœur de Manhattan, offrant un contraste saisissant avec les gratte-ciels environnants."),
        Visite(continent: "Amérique du Nord", pays: "États-Unis", ville: "New York", lieu: "Museum of Natural History", image: nil,
               description: "L'un des plus grands musées du monde, célèbre pour ses collections de fossiles de dinosaures, ses dioramas d'animaux grandeur nature et ses galeries sur l'évolution humaine."),
        Visite(continent: "Europe", pays: "France", ville: "Paris", lieu: "Tour Eiffel", image: .toureiffel,
               description: "Symbole incontournable de la France à travers le monde, cette majestueuse dame de fer construite pour l'Exposition universelle de 1889 domine la skyline parisienne du haut de ses 330 mètres.",
               estVisite: true, note: 5),
        Visite(continent: "Europe", pays: "France", ville: "Paris", lieu: "Musée du Louvre", image: .louvre,
               description: "Le plus grand musée d'art et d'antiquités au monde, ancienne résidence royale qui abrite des trésors universels comme La Joconde et la Vénus de Milo.",
               estVisite: true, note: 5),
        Visite(continent: "Europe", pays: "France", ville: "Paris", lieu: "Musée d'Orsay", image: .orsay,
               description: "Installé dans une magnifique ancienne gare ferroviaire, ce musée possède la plus grande collection de chefs-d'œuvre impressionnistes et post-impressionnistes au monde."),
        Visite(continent: "Europe", pays: "France", ville: "Paris", lieu: "Le Grand Palais", image: .grandpalais,
               description: "Un monument historique reconnaissable à sa verrière monumentale, édifié pour l'Exposition universelle de 1900 et dédié aux grandes expositions culturelles et événements internationaux."),
        Visite(continent: "Europe", pays: "Italie", ville: "Rome", lieu: "Colisée", image: nil,
               description: "Le plus grand amphithéâtre de l'Empire romain, chef-d'œuvre d'ingénierie antique qui accueillait autrefois les combats de gladiateurs."),
        Visite(continent: "Europe", pays: "Italie", ville: "Rome", lieu: "Vatican", image: nil,
               description: "Plus petit État indépendant au monde et centre spirituel de l'Église catholique, il abrite la majestueuse place et la basilique Saint-Pierre."),
        Visite(continent: "Europe", pays: "Italie", ville: "Rome", lieu: "La Chapelle Sixtine", image: nil,
               description: "Joyau des musées du Vatican, mondialement connue pour ses fresques de la Renaissance, notamment le plafond et Le Jugement dernier peints par Michel-Ange."),
        Visite(continent: "Europe", pays: "Italie", ville: "Rome", lieu: "La Fontaine de Trevi", image: nil,
               description: "La plus grande et la plus célèbre fontaine baroque de Rome, où la tradition veut que l'on jette une pièce pour revenir un jour dans la Ville Éternelle.")
    ]
}

/// Un continent affiché dans l'écran "Continents"
struct Continent: Identifiable {
    let id = UUID()
    let nom: String
    let image: ImageResource

    static let continent: [Continent] = [
        Continent(nom: "Afrique", image: .afrique),
        Continent(nom: "Europe", image: .europe),
        Continent(nom: "Asie", image: .asie),
        Continent(nom: "Amérique du Nord", image: .ameriqueDuNord),
        Continent(nom: "Amérique du Sud", image: .ameriqueDuSud),
        Continent(nom: "Australie", image: .autralie),
        Continent(nom: "Antarctique", image: .antarctique)
    ]
}

/// Filtre de la liste (bonus « visités »)
enum FiltreStatut: String, CaseIterable {
    case tous = "Tous"
    case visites = "Visités"
    case aDecouvrir = "À découvrir"
}

/// Image d'un lieu, avec un SF Symbol si le lieu n'a pas de photo
struct ImageLieu: View {
    let image: ImageResource?
    var taille: CGFloat = 50

    var body: some View {
        if let image {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: taille, height: taille)
                .clipShape(.rect(cornerRadius: taille / 4))
        } else {
            Image(systemName: "photo")
                .font(.system(size: taille / 2.5))
                .foregroundStyle(.brown)
                .frame(width: taille, height: taille)
                .background(Color.brown.opacity(0.15))
                .clipShape(.rect(cornerRadius: taille / 4))
        }
    }
}

/// Bonus : étoiles de notation (modifiables si une Binding est fournie)
struct Etoiles: View {
    @Binding var note: Int
    var modifiable = true

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { numero in
                Image(systemName: numero <= note ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
                    .onTapGesture {
                        if modifiable {
                            // Un tap sur l'étoile déjà sélectionnée remet la note à 0
                            note = (note == numero) ? 0 : numero
                        }
                    }
            }
        }
    }
}
