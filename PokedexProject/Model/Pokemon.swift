//
//  Pokemon.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//

import Foundation

struct Pokemon {
    let name: String
    let number: Int
    let pokemonImage: String
    let pokemonUrl: URL?
}

extension Pokemon {
    static func mock() -> Pokemon {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/2/") else { return Pokemon(name: "Ivysaur", number: 2, pokemonImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png", pokemonUrl: nil) }
        
        return Pokemon(name: "Ivysaur", number: 2, pokemonImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png", pokemonUrl: url)
    }
}
