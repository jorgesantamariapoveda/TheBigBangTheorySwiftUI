//
//  EpisodeList.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeList: View {

    @EnvironmentObject var episodesViewModel: ViewModelEpisodes

    @State var showSeason: [Bool] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(episodesViewModel.seasons, id:\.self) { season in
                    Section(
                        header: SeasonView(season: season),
                        content: {
                            ForEach(episodesViewModel.episodesBySeason(season: season)) { episode in
                                NavigationLink(
                                    destination: EpisodeDetail(episode: episode),
                                    label: { EpisodeSeason(episode: episode, showNameEpisode: true) }
                                )
                            }
                        }
                    )
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Episodes")
        }
        .onAppear {
            showSeason.append(contentsOf: Array(repeating: false, count: episodesViewModel.seasons.count))
        }
    }
}

struct SeasonView: View {

    @State var isShowAllEpisodesSeason: Bool = false

    let season: Int

    var body: some View {
        VStack {
            Text("Season \(season)")
                .font(.title2).bold()
            Image("season\(season)")
                .resizable()
                .scaledToFit()
            HStack {
                Toggle("Watched all episodes", isOn: $isShowAllEpisodesSeason)
                    .font(.footnote)
            }
            .padding([.horizontal, .bottom])
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
