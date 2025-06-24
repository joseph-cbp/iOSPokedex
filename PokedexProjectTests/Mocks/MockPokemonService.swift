//
//  MockPokemonService.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import Foundation
@testable import PokedexProject

final class MockPokemonService: PokemonServiceProtocol {
    var pokemonResult: Result<[Pokemon], Error>?
    var pokemonDetailResult: Result<Detail, Error>?
    
    func fetchPokemonList(completion: @escaping (Result<[PokedexProject.Pokemon], any Error>) -> Void) {
        if let result = pokemonResult {
            completion(result)
        }
    }
    
    func fetchPokemonDetail(from url: URL, completion: @escaping (Result<Detail, Error>) -> Void) {
        if let result = pokemonDetailResult {
            completion(result)
        }
    }
    
}
