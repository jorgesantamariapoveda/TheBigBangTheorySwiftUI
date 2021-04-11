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
            Text("Season \(season)")
                .font(.title2).bold()
            Image("season\(season)")
                .resizable()
                .scaledToFit()
                .padding([.horizontal, .bottom])
            Button(
                action: {
                    showAllEpisodes.toggle()
                },
                label: {
                    HStack {
                        Text(showAllEpisodes ? "Hide all episodes" : "Show all episodes")
                            .font(.headline)
                        Image(systemName: showAllEpisodes ? "chevron.right" : "chevron.down")
                    }
                })
            Button(
                action: {
                    marcar.toggle()
                    episodesViewModel.selectedAllEpisodesBySeason(season: season, isViewed: marcar)
                },
                label: {
                    HStack {
                        Text(marcar ? "Unviewed" : "Viewed")
                            .font(.headline)
                        Image(systemName: marcar ? "eye" : "eye.slash")
                    }
                })
        }
        .padding(.bottom)
    }}

struct SeasonHeader_Previews: PreviewProvider {
    
    static var episodesViewModel = ViewModelEpisodes()
    
    static var previews: some View {
        SeasonHeader(season: 1, showAllEpisodes: .constant(true))
            .environmentObject(episodesViewModel)
    }
}
