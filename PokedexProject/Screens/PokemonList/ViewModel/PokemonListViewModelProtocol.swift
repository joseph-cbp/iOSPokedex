//
//  PokemonListViewModelProtocol.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 01/10/26.
//
import Combine

protocol PokemonListViewModelProtocol: AnyObject, ObservableObject {
    var delegate: PokemonListViewModelDelegate? {get set}
    var pokemons: [Pokemon] {get}
    func fetchPokemons()
}
