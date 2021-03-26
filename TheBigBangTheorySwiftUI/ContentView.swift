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
                    Image(systemName: "film")
                    Text("Episodes")
                }
            FavoriteList()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
