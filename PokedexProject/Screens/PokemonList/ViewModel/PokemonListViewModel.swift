//
//  PokemonListViewModel.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//
import Foundation
import Combine

class PokemonListViewModel: PokemonListViewModelProtocol {
    weak var delegate: PokemonListViewModelDelegate?
    private let pokemonService: PokemonServiceProtocol
    @Published private(set) var pokemons: [Pokemon] = []
    
    init(pokemonService: PokemonServiceProtocol) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemons() {
        pokemonService.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons
                self?.delegate?.didUpdatePokemonList()
            case .failure(let error):
                self?.delegate?.didFailWithError(error.localizedDescription)
            }
        }
    }
}
