//
//  EpisodeSeason.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 05/04/2021.
//

import SwiftUI

struct EpisodeSeason: View {
    let episode: Episode
    let showNameEpisode: Bool

    @State private var isShow: Bool = false
    @State private var isFavorite: Bool = false
    @State private var numStars: Int = 1
    @State private var notes: String = ""

    var body: some View {
        VStack(spacing: 8) {
            if showNameEpisode {
                Text("[\(episode.number)] \(episode.name)").bold()
            }
            Toggle("Viewed", isOn: $isShow)
            Toggle("Favorite", isOn: $isFavorite)
            HStack {
                Text("Stars")
                Picker("Stars", selection: $numStars) {
                    ForEach(1..<6) { item in
                        Image(systemName: numStars + 1 >= item ? "star.fill" : "star").tag(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Notes")
                TextEditor(text: $notes)
            }
        }
        .frame(alignment: .leading)
    }
}

struct EpisodeSeason_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeSeason(episode: PersistenceModel.shared.testEpisode(), showNameEpisode: true)
    }
}
