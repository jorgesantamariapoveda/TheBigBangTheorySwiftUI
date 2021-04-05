//
//  FavoriteList.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct FavoriteList: View {
    @EnvironmentObject var episodesViewModel: ViewModelEpisodes

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(), GridItem()], content: {
                    ForEach(episodesViewModel.episodesFavorites()) { episodeFavorite in
                        if let episode = episodesViewModel.episodeById(id: episodeFavorite.id) {
                            NavigationLink(
                                destination: EpisodeDetail(episode: episode),
                                label: {
                                    VStack {
                                        Text("\(episode.name)")
                                            .font(.footnote)
                                        Image("\(episode.image)")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 135)
                                        Text("Stars: \(episodeFavorite.score)")
                                            .font(.footnote)
                                        Image(systemName: episodeFavorite.viewed ? "eye" : "eye.slash")
                                            .font(.footnote)
                                    }
                                    .padding(8)
                                }
                            )
                        }
                    }
                })
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        FavoriteList()
            .environmentObject(episodesViewModel)
    }
}
