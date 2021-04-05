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
        Text("\(episode.name)")
    }
}

struct EpisodeDetail_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetail(episode: PersistenceModel.shared.testEpisode())
    }
}
