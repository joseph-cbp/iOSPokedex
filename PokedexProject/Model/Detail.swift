//
//  Detail.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 14/06/25.
//

struct Detail: Decodable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let imageUrl: String
    let types: [PokemonTypes]
    let stats: [StatusDetail]
}

struct StatusDetail: Decodable {
    let baseStat: Int
    let name: String
}
