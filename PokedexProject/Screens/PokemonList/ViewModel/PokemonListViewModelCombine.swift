//
//  PokemonListViewModelCombine.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 01/10/26.
//

import Foundation
import Combine

class PokemonListViewModelCombine: PokemonListViewModelProtocol {
    private let pokemonService: PokemonCombineService
    weak var delegate: PokemonListViewModelDelegate?
    var cancellables = Set<AnyCancellable>()
    @Published private(set) var pokemons: [Pokemon] = []
    
    init(pokemonService: PokemonCombineService) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemons() {
        pokemonService.fetchPokemonListCombine()
            .map { response in
                response.results.map { $0.toDomainModel()}
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.delegate?.didFailWithError(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] pokemons in
                self?.pokemons = pokemons
                self?.delegate?.didUpdatePokemonList()
            }
            .store(in: &cancellables)
    }
}
