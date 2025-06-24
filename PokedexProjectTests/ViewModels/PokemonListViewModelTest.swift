//
//  PokemonListViewModelTest.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

@testable import PokedexProject

import XCTest

final class PokemonListViewModelTest: XCTestCase {
    private var suit: PokemonListViewModel!
    
    
    override func setUp() {
        super.setUp()
        suit = PokemonListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
