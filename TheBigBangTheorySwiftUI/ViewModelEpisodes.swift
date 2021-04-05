//
//  ViewModelEpisodes.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 05/04/2021.
//

import Foundation

final class ViewModelEpisodes: ObservableObject {

    @Published var episodes: [Episode]
    @Published var episodesEditables: [EpisodeEditable]

    var seasons: [Int] {
        Array(Set(episodes.map { $0.season })).sorted()
    }

    init() {
        episodes = PersistenceModel.shared.loadModel()
        episodesEditables = PersistenceModel.shared.loadModelEditable()
    }

    func episodesBySeason(season: Int) -> [Episode] {
        episodes.filter { $0.season == season}.sorted { $0.id < $1.id }
    }
    
}