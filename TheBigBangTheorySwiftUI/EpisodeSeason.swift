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
//                    ForEach(1..<3) { item in
//                        StarView(star: item, numStars: numStars)
//                    }
                    StarView(star: 1, numStars: numStars)
                    StarView(star: 2, numStars: numStars)
                    StarView(star: 3, numStars: numStars)
                    StarView(star: 4, numStars: numStars)
                    StarView(star: 5, numStars: numStars)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Notes")
                TextEditor(text: $notes)
            }
        }
        .frame(alignment: .leading)
    }}

struct EpisodeSeason_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeSeason(episode: PersistenceModel.shared.testEpisode(), showNameEpisode: true)
    }
}
