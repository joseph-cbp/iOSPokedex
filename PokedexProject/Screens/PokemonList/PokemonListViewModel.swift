//
//  PokemonListViewModel.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//
import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    weak var delegate: PokemonListViewModelDelegate?
    private let pokemonService: PokemonServiceProtocol
    @Published private(set) var pokemons: [Pokemon] = []
    
    var cancellables = Set<AnyCancellable>()
    
    
    
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
    
    func fetchPokemonsWithCombine() {
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



protocol PokemonListViewModelDelegate: AnyObject {
    func didUpdatePokemonList()
    func didFailWithError(_ message: String)
}
