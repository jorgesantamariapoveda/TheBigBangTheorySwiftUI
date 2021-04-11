//
//  EpisodeSeason.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 05/04/2021.
//

import SwiftUI

struct EpisodeSeason: View {

    @ObservedObject var components = EpisodeSeasonComponents()
    let episodeEditable: EpisodeEditable

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Viewed", isOn: $components.viewed)
            Toggle("Favorite", isOn: $components.isFavorite)
            HStack {
                Text("Stars")
                Picker("Stars", selection: $components.score) {
                    ForEach(0..<5) { item in
                        Image(systemName: components.score >= item ? "star.fill" : "star").tag(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Notes")
                TextEditor(text: $components.notes)
            }
        }
        .padding(.horizontal)
        .onAppear {
            components.initForm(episodeEditable: episodeEditable)
        }
    }
}

struct EpisodeSeason_Previews: PreviewProvider {

    static var previews: some View {
        EpisodeSeason(episodeEditable: PersistenceModel.shared.testEpisodeEditable())
    }
}
