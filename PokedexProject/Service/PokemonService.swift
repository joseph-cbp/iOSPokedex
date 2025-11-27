//
//  PokemonService.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//
import Foundation
import Combine

class PokemonService: PokemonServiceProtocol {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        
        networkManager.fetch(from: urlString, decodeTo: PokemonListResponse.self) { result in
            switch result {
            case .success(let response):
                let pokemons = response.results.map { $0.toDomainModel() }
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPokemonDetail(from url: URL, completion: @escaping (Result<Detail, Error>) -> Void) {
        networkManager.fetch(from: url.absoluteString, decodeTo: DetailResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.toDomainModel()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: Combine
    func fetchPokemonListCombine() -> AnyPublisher<PokemonListResponse, Error> {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=151"
        guard let url = URL(string: urlString) else {
            return Fail(error: ServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        return networkManager.fetchWithCombine(url, type: PokemonListResponse.self)
    }
}
