//
//  Model.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 29/03/2021.
//

import Foundation

struct Episode: Codable, Identifiable, Hashable {
    let id: Int
    let season: Int
    let number: Int
    let summary: String
    let runtime: Int
    let airdate: String
    let image: String
    let name: String
    let url: URL
}

struct EpisodeEditable: Codable, Identifiable {
    let id: Int
    let season: Int
    var viewed: Bool
    var isFavorite: Bool
    var score: Int
    var notes: String
}

struct PersistenceModel {

    static let shared = PersistenceModel()
    static private let filenameEpisoseEditable = "episodesEditable"

    func loadModel() -> [Episode] {
        guard let url = Bundle.main.url(forResource: "BigBang", withExtension: "json") else {
            return []
        }

        if let model = loadJSON(url: url, type: [Episode].self) {
            return model
        }
        return []
    }

    func loadModelEditable() -> [EpisodeEditable] {
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        url.appendPathComponent(PersistenceModel.filenameEpisoseEditable)
        url.appendPathExtension("json")
        print("\(url.path)")

        if let model = loadJSON(url: url, type: [EpisodeEditable].self) {
            return model
        }
        return []
    }

    private func loadJSON<T:Codable>(url: URL, type: T.Type) -> T? {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error en la carga \(error)")
            return nil
        }
    }

    func saveJSON<T:Codable>(data:[T]) {
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        url.appendPathComponent(PersistenceModel.filenameEpisoseEditable)
        url.appendPathExtension("json")
        do {
            let json = try JSONEncoder().encode(data)
            try json.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error en la carga \(error)")
        }
    }

    func testEpisode() -> Episode {
        Episode(
            id: 2913,
            season: 1,
            number: 1,
            summary: "Is a comedy about brilliant physicists, Leonard and Sheldon, who are the kind of \"beautiful minds\" that understand how the universe works. But none of that genius helps them interact with people, especially women. All this begins to change when a free-spirited beauty named Penny moves in next door. Sheldon, Leonard's roommate, is quite content spending his nights playing Klingon Boggle with their socially dysfunctional friends, fellow Cal Tech scientists Wolowitz and Koothrappali. However, Leonard sees in Penny a whole new universe of possibilities... including love.\n",
            runtime: 30,
            airdate: "2007-09-24",
            image: "12368",
            name: "Pilot",
            url: URL(string: "https://www.tvmaze.com/episodes/2913/the-big-bang-theory-1x01-pilot")!
        )
    }

    func testEpisodeEditable() -> EpisodeEditable {
        EpisodeEditable(id: 1, season: 1, viewed: false, isFavorite: false, score: 1, notes: "test")
    }

}
