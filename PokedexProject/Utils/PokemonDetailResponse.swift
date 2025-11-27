//
//  PokemonDetailResponse.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 15/06/25.
//
import Foundation

class DetailResponse: Codable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let types: [TypeData]
    let stats: [StatusData]

    func toDomainModel() -> Detail {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "raw.githubusercontent.com"
        urlComponents.path = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        guard let imageUrl = urlComponents.url else { fatalError("Invalid URL") }
        return Detail(
            id: id,
            name: name,
            height: height,
            weight: weight,
            imageUrl: imageUrl,
            types: types.compactMap { PokemonTypes(rawValue: $0.type.name)},
            stats: stats.compactMap {StatusDetail(baseStat: $0.base_stat, name: $0.stat.name)}
        )
    }
}

struct TypeData: Codable {
    let type: TypeElement
}

struct TypeElement: Codable {
    let name: String
}

struct StatusData: Codable {
    let base_stat: Int
    let stat: StatusElement

}

struct StatusElement: Codable {
    let name: String
}
