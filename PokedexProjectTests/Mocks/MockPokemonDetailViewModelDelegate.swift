//
//  MockPokemonDetailViewModelDelegate.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 25/06/25.
//

import Foundation
@testable import PokedexProject

final class MockPokemonDetailViewModelDelegate: PokemonDetailViewModelDelegate {
    var didSuccessfullyFetchPokemonDetailCalled: Bool = false
    var fetchedPokemonDetail: Detail? = nil
    
    var didFailToFetchPokemonDetailCalled: Bool = false
    var messageError: String? = nil
    
    func didSuccessfullyFetchPokemonDetail(pokemon: Detail) {
        didSuccessfullyFetchPokemonDetailCalled = true
        fetchedPokemonDetail = pokemon
    }
    
    func didFailToFetchPokemonDetail(error: Error) {
        didFailToFetchPokemonDetailCalled = true
        messageError = error.localizedDescription
    }
    
    
}

