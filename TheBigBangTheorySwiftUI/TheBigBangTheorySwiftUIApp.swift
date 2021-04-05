//
//  TheBigBangTheorySwiftUIApp.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

@main
struct TheBigBangTheorySwiftUIApp: App {
    @StateObject var episodesViewModel = ViewModelEpisodes()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(episodesViewModel)
        }
    }
}
