//
//  PokemonDetailViewModel.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 14/06/25.
//

import UIKit

protocol PokemonDetailViewModelDelegate: AnyObject{
    func didSuccessfullyFetchPokemonDetail(pokemon: Detail)
    func didFailToFetchPokemonDetail(error: Error)
}

class PokemonDetailViewModel {
    let url: URL?
    let service: PokemonService
    weak var delegate: PokemonDetailViewModelDelegate?
    
    init(url: URL?) {
        self.url = url
        self.service = PokemonService()
    }
    
    func fetchPokemonDetail(){
        guard let url = url else { return }
        service.fetchPokemonDetail(from: url) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.delegate?.didSuccessfullyFetchPokemonDetail(pokemon: pokemon)
                
            case .failure(let error):
                self?.delegate?.didFailToFetchPokemonDetail(error: error)
            }
        }
    }
    
}
