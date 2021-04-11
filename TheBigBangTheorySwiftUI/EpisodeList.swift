//
//  EpisodeList.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeList: View {

    @EnvironmentObject var episodesViewModel: ViewModelEpisodes
    @State var show = false

    var body: some View {
        NavigationView {
            List {
                SearchBarSwiftUI()
                ForEach(episodesViewModel.seasons, id:\.self) { season in
                    let episodes = episodesViewModel.episodesBySeason(season: season)
                    if episodes.count > 0 {
                        Section(header:
                                    SeasonView(season: season, show: $show)
                                    .onTapGesture { show.toggle() },
                                content: {
                                    if show {
                                        ForEach(episodes) { episode in
                                            if let episodeEditable = episodesViewModel.episodeEditableById(id: episode.id) {
                                                NavigationLink(
                                                    destination: EpisodeDetail(episode: episode, episodeEditable: episodeEditable),
                                                    label: {
                                                        Text("[\(episode.number)] \(episode.name)")
                                                            .font(.callout)
                                                            .lineLimit(1)
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
            .navigationTitle("Episodes")
            .animation(.linear)
        }
    }
}

struct SeasonView: View {

    @EnvironmentObject var episodesViewModel: ViewModelEpisodes

    let season: Int
    @Binding var show: Bool

    @State var marcar = false

    var body: some View {
        VStack {
            Text("Season \(season)")
                .font(.title2).bold()
            Image("season\(season)")
                .resizable()
                .scaledToFit()
                .padding([.horizontal, .bottom])
            Button(action: { show.toggle() }, label: {
                HStack {
                    Text(show ? "Hide all episodes" : "Show all episodes")
                        .font(.headline)
                    Image(systemName: show ? "chevron.right" : "chevron.down")
                }
            })
            Button(
                action: {
                    marcar.toggle()
                    episodesViewModel.selectedAllEpisodesBySeason(season: season, isViewed: marcar)
                },
                label: {
                    HStack {
                        Text(marcar ? "Unviewed" : "Viewed")
                            .font(.headline)
                        Image(systemName: marcar ? "eye" : "eye.slash")
                    }
                })
        }
        .padding(.bottom)
    }
}

struct EpisodeList_Previews: PreviewProvider {

    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        EpisodeList()
            .environmentObject(episodesViewModel)
    }
}
