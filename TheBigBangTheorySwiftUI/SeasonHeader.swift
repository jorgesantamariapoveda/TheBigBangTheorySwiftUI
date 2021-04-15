//
//  SeasonHeader.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 11/04/2021.
//

import SwiftUI

struct SeasonHeader: View {

    @EnvironmentObject var episodesViewModel: ViewModelEpisodes

    let season: Int
    @Binding var showAllEpisodes: Bool

    @State var marcar = false

    var body: some View {
        VStack {
            HStack {
                Text("Season \(season)")
                    .font(.title2).bold()
                Button(
                    action: {
                        marcar.toggle()
                        episodesViewModel.selectedAllEpisodesBySeason(season: season, isViewed: marcar)
                    },
                    label: {
                        Image(systemName: marcar ? "eye" : "eye.slash")
                    })
            }
            HStack {
                Image("season\(season)")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding([.horizontal, .bottom])
                Button(
                    action: {
                        showAllEpisodes.toggle()
                    },
                    label: {
                        Image(systemName: showAllEpisodes ? "chevron.right" : "chevron.down")
                })
            }
        }
    }}

struct SeasonHeader_Previews: PreviewProvider {

    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        SeasonHeader(season: 1, showAllEpisodes: .constant(true))
            .environmentObject(episodesViewModel)
    }
}
