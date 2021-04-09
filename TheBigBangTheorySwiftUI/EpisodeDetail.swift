//
//  EpisodeDetail.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeDetail: View {
    let episode: Episode

    var body: some View {
        ScrollView {
            VStack {
                Image("\(episode.image)")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                HStack {
                    Text("Episode: \(episode.number)")
                    Spacer()
                    Text("Runtime: \(episode.runtime)")
                }.padding([.horizontal, .top])
                HStack {
                    Text("Season: \(episode.season)")
                    Spacer()
                    Text("Airdate: \(episode.airdate)")
                }.padding(.horizontal)
                Text("\(episode.summary)")
                    .padding([.horizontal, .top])
                Text("URL: \(episode.url)")
                    .font(.footnote)
                    .padding([.horizontal, .top])
                Divider()
                    .padding()
                EpisodeSeason(episode: episode, showNameEpisode: false)
                    .padding(.horizontal)
            }
        }
        .navigationBarTitle("\(episode.name)", displayMode: .inline)
    }
}

struct EpisodeDetail_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetail(episode: PersistenceModel.shared.testEpisode())
    }
}
