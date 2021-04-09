//
//  ViewModelEpisodes.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 05/04/2021.
//

import SwiftUI

final class ViewModelEpisodes: ObservableObject {

    @Published var episodes: [Episode]
    
    @Published var episodesEditables: [EpisodeEditable] {
        didSet {
            PersistenceModel.shared.saveJSON(data: episodesEditables)
        }
    }

    var seasons: [Int] {
        Array(Set(episodes.map { $0.season })).sorted()
    }

    init() {
        episodes = PersistenceModel.shared.loadModel()

        episodesEditables = PersistenceModel.shared.loadModelEditable()
        if episodesEditables.isEmpty {
            episodes.forEach { episode in
                let newEpisodeEditable = EpisodeEditable(
                    id: episode.id,
                    season: episode.season,
                    viewed: false,
                    isFavorite: true,
                    score: 1,
                    notes: "")
                episodesEditables.append(newEpisodeEditable)
            }
        }
    }

    // MARK: - Episodes...

    func episodesBySeason(season: Int) -> [Episode] {
        episodes.filter { $0.season == season}.sorted { $0.id < $1.id }
    }

    func episodeById(id: Int) -> Episode? {
        episodes.filter { $0.id == id }.first ?? nil
    }

    // MARK: - Episodes editables...

    func updateEpisodeEditable(episode: EpisodeEditable, index: Int) {
        episodesEditables[index] = episode
    }

    func episodesEditablesFavorites() -> [EpisodeEditable] {
        episodesEditables.filter { $0.isFavorite }
    }

}
