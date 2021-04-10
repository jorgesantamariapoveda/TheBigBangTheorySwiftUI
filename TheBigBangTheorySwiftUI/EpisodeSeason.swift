//
//  EpisodeSeason.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 05/04/2021.
//

import SwiftUI

struct EpisodeSeason: View {

    @ObservedObject var components = EpisodeEditableComponents()
    let episode: EpisodeEditable

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Viewed", isOn: $components.viewed)
            Toggle("Favorite", isOn: $components.isFavorite)
            HStack {
                Text("Stars")
                Picker("Stars", selection: $components.score) {
                    ForEach(1..<6) { item in
                        Image(systemName: components.score + 1 > item ? "star.fill" : "star").tag(item)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Notes")
                TextEditor(text: $components.notes)
            }
        }
        .onAppear {
            components.initForm(episode: episode)
        }
    }
}

struct EpisodeSeason_Previews: PreviewProvider {
    
    static var previews: some View {
        EpisodeSeason(episode: PersistenceModel.shared.testEpisodeEditable())
    }
}
