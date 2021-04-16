//
//  ContentView.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct ContentView: View {

    @State var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            EpisodeList()
                .tabItem {
                    Label("Episodes",
                          systemImage: selection == 0 ? "film.fill" : "film")
                }
                .tag(0)

            FavoriteList()
                .tabItem {
                    Label("Favorites",
                          systemImage: selection == 1 ? "heart.fill" : "heart")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        ContentView()
            .environmentObject(episodesViewModel)
    }
}
