//
//  EpisodeDetail.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeDetail: View {

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var episodesViewModel: ViewModelEpisodes
    let episode: Episode

    var body: some View {
        ScrollView {
            VStack {
                Image("\(episode.image)")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                HStack {
                    Text("Episode: \(episode.number)")
                    Spacer()
                    Text("Runtime: \(episode.runtime)")
                }
                .padding(.top)
                HStack {
                    Text("Season: \(episode.season)")
                    Spacer()
                    Text("Airdate: \(episode.airdate)")
                }
                Text("\(episode.summary)")
                    .padding(.top)
                Text("\(episode.url)")
                    .font(.footnote)
                    .padding(.top, 5)
                Divider()
                if let episodeEditable = episodesViewModel.episodeEditableById(id: episode.id) {
                    EpisodeSeason(episode: episodeEditable)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("\(episode.name)", displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: { presentation.wrappedValue.dismiss() },
                label: { Text("Cancel") }),
            trailing: Button(
                action: {
                    if let episodeEditable = episodesViewModel.episodeEditableById(id: episode.id) {
                        episodesViewModel.updateEpisodeEditable(episode: episodeEditable)
                    }
                },
                label: { Text("Save") }))
        .navigationBarBackButtonHidden(true)
    }
}

struct EpisodeDetail_Previews: PreviewProvider {
    
    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        NavigationView {
            EpisodeDetail(episode: PersistenceModel.shared.testEpisode())
                .environmentObject(episodesViewModel)
        }
    }
}
