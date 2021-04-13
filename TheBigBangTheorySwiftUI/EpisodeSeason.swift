//
//  EpisodeSeason.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 05/04/2021.
//

import SwiftUI

struct EpisodeSeason: View {

    @ObservedObject var episodeComponents = EpisodeComponents()
    
    let episodeEditable: EpisodeEditable

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Viewed", isOn: $episodeComponents.viewed)
            Toggle("Favorite", isOn: $episodeComponents.isFavorite)
            HStack {
                Text("Stars")
                Picker("Stars", selection: $episodeComponents.score) {
                    ForEach(0..<5) { item in
                        Image(systemName: episodeComponents.score >= item ? "star.fill" : "star").tag(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Notes")
                TextEditor(text: $episodeComponents.notes)
            }
        }
        .padding(.horizontal)
        .onAppear {
            episodeComponents.initForm(episodeEditable: episodeEditable)
        }
    }
}

struct EpisodeSeason_Previews: PreviewProvider {

    static var previews: some View {
        EpisodeSeason(episodeEditable: PersistenceModel.shared.testEpisodeEditable())
    }
}
