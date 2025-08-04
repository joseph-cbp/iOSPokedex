//
//  PokemonServiceProtocol.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import Foundation
import Combine

protocol PokemonServiceProtocol: AnyObject{
    
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void)
    
    func fetchPokemonDetail(from url: URL, completion: @escaping (Result<Detail, Error>) -> Void)
    
    func fetchPokemonListCombine() -> AnyPublisher<PokemonListResponse, Error>
    
}
