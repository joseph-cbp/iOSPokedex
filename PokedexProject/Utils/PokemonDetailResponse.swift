//
//  PokemonDetailResponse.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 15/06/25.
//

class DetailResponse: Codable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    
    
    func toDomainModel() -> Detail {
        
        let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        
        return Detail(
            id: id,
            name: name,
            height: height,
            weight: weight,
            imageUrl: imageUrl
        )
    }
}
