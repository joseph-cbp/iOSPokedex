//
//  PokemonListViewModelTest.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

@testable import PokedexProject

import XCTest

final class PokemonListViewModelTest: XCTestCase {
    private var sut: PokemonListViewModel!
    private var mockDelegate: MockPokemonListViewModelDelegate!
    private var mockService: MockPokemonService!
    
    
    override func setUp() {
        super.setUp()
        mockDelegate = MockPokemonListViewModelDelegate()
        mockService = MockPokemonService()
        sut = PokemonListViewModel(pokemonService: mockService)
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockDelegate = nil
        super.tearDown()
    }
    //test_fetchPokemons_whenSuccess_shouldNotifyDelegateAndStoreData
    func test_fetchPokemons_whenSuccess_shouldNotifyDelegateAndStoreData() {
        
        let pokemons = MockResponses.createMockPokemonResponse()
        let toDomainModel = pokemons.results.map{ $0.toDomainModel()}
        mockService.pokemonResult = .success(toDomainModel)
        
        sut.fetchPokemons()
        
        XCTAssertTrue(mockDelegate.didUpdateCalled)
        XCTAssertEqual(sut.pokemons.count, 2)
        XCTAssertEqual(sut.pokemons[0].name, "Bulbasaur")
        XCTAssertEqual(sut.pokemons[0].number, 1)
    }
    //test_fetchPokemons_whenFailure_shouldNotifyDelegateWithError
    func test_fetchPokemons_whenFailure_shouldNotifyDelegateWithError() {
        mockService.pokemonResult = .failure(NSError(domain: "I Know", code: 500, userInfo: [NSLocalizedDescriptionKey: "Should Fail"]))
        sut.fetchPokemons()
        
        XCTAssertTrue(mockDelegate.didFailWithErrorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Should Fail")
    }
}
