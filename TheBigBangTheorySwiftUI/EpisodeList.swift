//
//  EpisodeList.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeList: View {

    @EnvironmentObject var episodesViewModel: ViewModelEpisodes
    @State var showAllEpisodes = false

    var body: some View {
        NavigationView {
            List {
                SearchBarSwiftUI()
                ForEach(episodesViewModel.seasons, id:\.self) { season in
                    let episodes = episodesViewModel.episodesBySeason(season: season)
                    if episodes.count > 0 {
                        Section(header:
                                    SeasonHeader(season: season, showAllEpisodes: $showAllEpisodes)
                                    .onTapGesture { showAllEpisodes.toggle() },
                                content: {
                                    if showAllEpisodes {
                                        ForEach(episodes) { episode in
                                            if let episodeEditable = episodesViewModel.episodeEditableById(id: episode.id) {
                                                NavigationLink(
                                                    destination: EpisodeDetail(episode: episode, episodeEditable: episodeEditable),
                                                    label: {
                                                        HStack {
                                                            Text("[\(episode.number)] \(episode.name)")
                                                                .font(.callout)
                                                                .lineLimit(1)
                                                                .minimumScaleFactor(0.5)
                                                            Spacer()
                                                            Image(systemName: "eye")
                                                                .opacity(episodeEditable.viewed ? 1: 0)
                                                            Image(systemName: "heart.fill")
                                                                .opacity(episodeEditable.isFavorite ? 1: 0)
                                                        }
                                                    }
                                                )
                                            }
                                        }
                                    }
                                }
                        )
                    }
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle("The Big Bang Theory")
            .animation(.linear)
        }
    }
}

struct EpisodeList_Previews: PreviewProvider {

    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        EpisodeList()
            .environmentObject(episodesViewModel)
    }
}
