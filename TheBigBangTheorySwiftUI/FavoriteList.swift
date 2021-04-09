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
                    ForEach(episodesViewModel.episodesEditablesFavorites()) { episodeFavorite in
                        if let episode = episodesViewModel.episodeById(id: episodeFavorite.id) {
                            NavigationLink(
                                destination: EpisodeDetail(episode: episode),
                                label: {
                                    FavoriteView(episode: episode, episodeFavorite: episodeFavorite)
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

struct FavoriteView: View {
    let episode: Episode
    let episodeFavorite: EpisodeEditable

    var body: some View {
        VStack(alignment: .center) {
            Text("\(episode.name)")
                .font(.footnote)
                .lineLimit(1)
                .padding(.horizontal)
            Image("\(episode.image)")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 100)
                .cornerRadius(10)
            Text("Stars: \(episodeFavorite.score)")
                .font(.footnote)
            Image(systemName: episodeFavorite.viewed ? "eye" : "eye.slash")
                .font(.footnote)
        }
        .padding(8)
    }
}
