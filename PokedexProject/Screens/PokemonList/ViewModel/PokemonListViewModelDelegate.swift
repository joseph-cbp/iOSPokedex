//
//  PokemonListViewModelDelegate.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 01/10/26.
//

protocol PokemonListViewModelDelegate: AnyObject {
    func didUpdatePokemonList()
    func didFailWithError(_ message: String)
}
