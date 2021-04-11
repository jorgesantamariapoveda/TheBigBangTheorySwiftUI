//
//  EpisodeEditableComponents.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 10/04/2021.
//

import SwiftUI

final class EpisodeSeasonComponents: ObservableObject {

    @Published var viewed = false
    @Published var isFavorite = false
    @Published var score = 5
    @Published var notes = "Desde components"

    func initForm(episodeEditable: EpisodeEditable) {
        viewed = episodeEditable.viewed
        isFavorite = episodeEditable.isFavorite
        score = episodeEditable.score
        notes = episodeEditable.notes
    }

    func newEpisodeEditable(episode: EpisodeEditable) -> EpisodeEditable {
        EpisodeEditable(
            id: episode.id,
            season: episode.season,
            viewed: viewed,
            isFavorite: isFavorite,
            score: score,
            notes: notes)
    }

}
