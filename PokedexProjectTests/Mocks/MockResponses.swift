//
//  MockResponses.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import Foundation

@testable import PokedexProject

struct MockResponses {
    
    static func createMockPokemonResponse() -> PokemonListResponse {
        let pokemon1 = PokemonResponse(name: "bulbasaur", pokemonUrl: "https://pokeapi.co/api/v2/pokemon/1/")
        let pokemon2 = PokemonResponse(name: "ivysaur", pokemonUrl: "https://pokeapi.co/api/v2/pokemon/2/")
        
        return PokemonListResponse(results: [pokemon1, pokemon2])
    }
    
    static func createMockPokemonDetailResponse() -> Detail{
        let types: [PokemonTypes] = [.grass, .poison]
        let status: [StatusDetail] = [
            .init(baseStat: 45, name: "hp"),
            .init(baseStat: 49, name: "attack"),
            .init(baseStat: 49, name: "defense"),
            .init(baseStat: 65, name: "special-attack"),
            .init(baseStat: 65, name: "special-defense"),
            .init(baseStat: 45, name: "speed")
        ]
        
        let detail = Detail(id: 1, name: "bulbasaur", height: 7.0, weight: 69.0, imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png", types: types, stats: status)
        
        return detail
    }
}
