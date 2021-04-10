//
//  EpisodeEditableComponents.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 10/04/2021.
//

import SwiftUI

final class EpisodeEditableComponents: ObservableObject {

    @Published var viewed = true
    @Published var isFavorite = true
    @Published var score = 5
    @Published var notes = "components"

    func initForm(episode: EpisodeEditable) {
        viewed = episode.viewed
        isFavorite = episode.isFavorite
        score = episode.score
        notes = episode.notes
    }

}
