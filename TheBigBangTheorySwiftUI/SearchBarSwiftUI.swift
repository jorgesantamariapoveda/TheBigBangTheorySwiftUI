//
//  SearchBarSwiftUI.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 11/04/2021.
//

import SwiftUI

struct SearchBarSwiftUI: View {

    @EnvironmentObject var episodesViewModel: ViewModelEpisodes

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .opacity(0.5)
            TextField("Search an episode", text: $episodesViewModel.search)
            Button(
                action: {
                    episodesViewModel.search = ""
                },
                label: {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(episodesViewModel.search.isEmpty ? 0.0 : 0.3)
                }
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.gray.opacity(0.2))
        )
    }
}

struct SearchBarSwiftUI_Previews: PreviewProvider {

    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        SearchBarSwiftUI()
            .environmentObject(episodesViewModel)
    }
}
