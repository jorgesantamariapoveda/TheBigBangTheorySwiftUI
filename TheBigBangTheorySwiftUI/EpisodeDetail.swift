//
//  EpisodeDetail.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeDetail: View {

    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var episodesViewModel: ViewModelEpisodes

    @ObservedObject var components = EpisodeSeasonComponents()
    
    let episode: Episode
    let episodeEditable: EpisodeEditable

    var body: some View {
        ScrollView {
            VStack {
                ViewEpisodeNotEditable
                Divider()
                VStack(spacing: 8) {
                    Toggle("Viewed", isOn: $components.viewed)
                    Toggle("Favorite", isOn: $components.isFavorite)
                    HStack {
                        Text("Stars")
                        Picker("Stars", selection: $components.score) {
                            ForEach(0..<5) { item in
                                Image(systemName: components.score >= item ? "star.fill" : "star").tag(item)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Notes")
                        TextEditor(text: $components.notes)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationBarTitle("\(episode.name)", displayMode: .inline)
        .navigationBarItems(
            leading: Button(
                action: { presentation.wrappedValue.dismiss() },
                label: { Text("Cancel") }),
            trailing: Button(
                action: {
                    let newEpisodeEditable = components.newEpisodeEditable(episode: episodeEditable)
                    episodesViewModel.updateEpisodeEditable(episode: newEpisodeEditable)
                    presentation.wrappedValue.dismiss()
                },
                label: { Text("Save") }))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            components.initForm(episodeEditable: episodeEditable)
        }
    }

    var ViewEpisodeNotEditable: some View {
        VStack {
            Image("\(episode.image)")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            HStack {
                Text("Episode: \(episode.number)")
                Spacer()
                Text("Runtime: \(episode.runtime)")
            }
            .padding(.top)
            HStack {
                Text("Season: \(episode.season)")
                Spacer()
                Text("Airdate: \(episode.airdate)")
            }
            Text("\(episode.summary)")
                .padding(.top)
            Text("\(episode.url)")
                .font(.footnote)
                .padding(.top, 5)
        }
    }
}

struct EpisodeDetail_Previews: PreviewProvider {
    
    static var episodesViewModel = ViewModelEpisodes()

    static var previews: some View {
        NavigationView {
            EpisodeDetail(episode: PersistenceModel.shared.testEpisode(),
                          episodeEditable: PersistenceModel.shared.testEpisodeEditable())
                .environmentObject(episodesViewModel)
        }
    }
}
