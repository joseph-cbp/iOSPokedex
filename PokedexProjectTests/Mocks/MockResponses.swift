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
}
