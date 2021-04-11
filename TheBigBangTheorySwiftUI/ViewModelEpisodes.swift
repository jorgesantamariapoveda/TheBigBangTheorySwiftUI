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

    @Published var search = ""

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
                    isFavorite: false,
                    score: 0,
                    notes: "")
                episodesEditables.append(newEpisodeEditable)
            }
        }
    }

    // MARK: - Episodes...

    func episodesBySeason(season: Int) -> [Episode] {
        if search.isEmpty {
            return episodes
                .filter { $0.season == season }
                .sorted { $0.id < $1.id }
        } else {
            return episodes
                .filter { $0.season == season }
                .sorted { $0.id < $1.id }
                .filter { $0.name.contains(search) }
        }
    }

    func episodeById(id: Int) -> Episode? {
        episodes.filter { $0.id == id }.first ?? nil
    }

    func showEpisodesSeason(season: Int) -> Bool {
        true
    }

    // MARK: - Episodes editables...

    func episodeEditableById(id: Int) -> EpisodeEditable? {
        episodesEditables.first { $0.id == id }
    }

    func updateEpisodeEditable(episode: EpisodeEditable) {
        if let index = episodesEditables.firstIndex(where: { $0.id == episode.id }) {
            episodesEditables[index] = episode
        }
    }

    func episodesEditablesFavorites() -> [EpisodeEditable] {
        episodesEditables.filter { $0.isFavorite }
    }

    func selectedAllEpisodesBySeason(season: Int, isViewed: Bool) {
        let episodesEditablesSeason = episodesEditables.filter { $0.season == season }
        episodesEditablesSeason.forEach { episode in
            if let index = episodesEditables.firstIndex(where: { $0.id == episode.id }) {
                let newEpisodeEditable = EpisodeEditable(
                    id: episode.id,
                    season: episode.season,
                    viewed: isViewed,
                    isFavorite: episode.isFavorite,
                    score: episode.season,
                    notes: episode.notes)
                episodesEditables[index] = newEpisodeEditable
            }
        }
    }

}
