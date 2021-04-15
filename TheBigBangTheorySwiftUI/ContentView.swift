//
//  ContentView.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            EpisodeList()
                .tabItem {
                    Label("Episodes", systemImage: "film")
                }
            FavoriteList()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
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
