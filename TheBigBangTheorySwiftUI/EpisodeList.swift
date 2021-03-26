//
//  EpisodeList.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 26/03/2021.
//

import SwiftUI

struct EpisodeList: View {
    @State var visto = false
    @State var favorito = false
    @State var puntuacion: CGFloat = 1

    var body: some View {
        List {
            HStack {
                VStack(alignment: .leading) {
                    Text("Nombre")
                    Toggle("Visto", isOn: $visto)
                    Toggle("Favorito", isOn: $favorito)
                    Slider(value: $puntuacion,
                           in: 1...5,
                           minimumValueLabel: Text("1"),
                           maximumValueLabel: Text("5"),
                           label: { Text("Espaciado") })
                }
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.horizontal)
            }
        }
    }
}

struct EpisodeList_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeList()
    }
}
