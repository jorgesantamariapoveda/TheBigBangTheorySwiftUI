//
//  Model.swift
//  TheBigBangTheorySwiftUI
//
//  Created by Jorge on 29/03/2021.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let season: Int
    let number: Int
    let summary: String
    let runtime: Int
    let airdate: String
    let image: String
    let name: String
    let url: URL
}
