//
//  MockPokemonListViewModelDelegate.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import Foundation
@testable import PokedexProject

final class MockPokemonListViewModelDelegate: PokemonListViewModelDelegate {
    
    var didUpdateCalled: Bool = false
    var didFailWithErrorCalled: Bool = false
    var errorMessage: String?
    
    func didUpdatePokemonList() {
        didUpdateCalled = true
    }
    
    func didFailWithError(_ message: String) {
        didFailWithErrorCalled = true
        errorMessage = message
    }
    

}
