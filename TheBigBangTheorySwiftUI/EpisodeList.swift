//
//  EpisodeList.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeList: View {
    @EnvironmentObject var episodesViewModel: ViewModelEpisodes
    
    @State private var isExpanded = false
    @State private var isWatchedAllEpisodes = false
    @State private var isExpandedSeasons: [Bool] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(episodesViewModel.seasons, id:\.self) { season in
                    DisclosureGroup(
                        isExpanded: $isExpanded,
                        content: {
                            ForEach(episodesViewModel.episodesBySeason(season: season)) { episode in
                                NavigationLink(
                                    destination: EpisodeDetail(episode: episode),
                                    label: { EpisodeView(episode: episode) }
                                )
                            }
                        },
                        label: { SeasonView(isShowAllEpisodesSeason: $isWatchedAllEpisodes, season: season)}
                    )
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle("Episodes")
        }
        .onAppear {
            isExpandedSeasons.append(contentsOf: Array(repeating: false, count: episodesViewModel.seasons.count))
        }
    }
}

struct SeasonView: View {
    @Binding var isShowAllEpisodesSeason: Bool

    let season: Int

    var body: some View {
        VStack {
            Text("Season \(season)")
                .font(.title)
            Image("season\(season)")
                .resizable()
                .scaledToFit()
            HStack {
                Toggle("Watched all episodes", isOn: $isShowAllEpisodesSeason)
                    .font(.footnote)
            }.padding([.horizontal, .bottom])
        }
    }
}

struct EpisodeView: View {
    let episode: Episode

    @State private var isShow: Bool = false
    @State private var isFavorite: Bool = false
    @State private var numStars: Int = 1
    @State private var notes: String = ""

    var body: some View {
        VStack(spacing: 8) {
            Text("[\(episode.number)] \(episode.name)").bold()
            Toggle("Viewed", isOn: $isShow)
            Toggle("Favorite", isOn: $isFavorite)
            HStack {
                Text("Stars")
                Picker("Stars", selection: $numStars) {
//                    ForEach(1..<3) { item in
//                        StarView(star: item, numStars: numStars)
//                    }
                    StarView(star: 1, numStars: numStars)
                    StarView(star: 2, numStars: numStars)
                    StarView(star: 3, numStars: numStars)
                    StarView(star: 4, numStars: numStars)
                    StarView(star: 5, numStars: numStars)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            HStack {
                Text("Notes")
                TextField("Notes...", text: $notes)
            }
        }
        .frame(alignment: .leading)
    }
}

struct StarView: View {
    let star: Int
    let numStars: Int

    var body: some View {
        Image(systemName: numStars >= star ? "star.fill" : "star").tag(star)
    }
}

struct EpisodeList_Previews: PreviewProvider {
    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        EpisodeList()
            .environmentObject(episodesViewModel)
    }
}
