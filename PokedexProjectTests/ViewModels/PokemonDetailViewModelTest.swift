//
//  PokemonDetailViewModelTest.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 25/06/25.
//

import XCTest
@testable import PokedexProject

final class PokemonDetailViewModelTest: XCTestCase {
    var mockUrl: URL!
    var mockPokemonService: MockPokemonService!
    var mockDelegate: MockPokemonDetailViewModelDelegate!
    var sut: PokemonDetailViewModel!
    
    override func setUp() {
        mockUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/1/")
        mockPokemonService = MockPokemonService()
        mockDelegate = MockPokemonDetailViewModelDelegate()
        sut = PokemonDetailViewModel(url: mockUrl, service: mockPokemonService)
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        mockPokemonService = nil
        mockDelegate = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchPokemon_whenSuccess_callsDelegateWithPokemon() {
        let pokemon = MockResponses.createMockPokemonDetailResponse()
        mockPokemonService.pokemonDetailResult = .success(pokemon)
        
        sut.fetchPokemonDetail()
        
        XCTAssertTrue(mockDelegate.didSuccessfullyFetchPokemonDetailCalled)
        XCTAssertNotNil(mockDelegate.fetchedPokemonDetail)
        XCTAssertEqual(mockDelegate.fetchedPokemonDetail?.name, "bulbasaur")
        XCTAssertEqual(mockDelegate.fetchedPokemonDetail?.id, 1)
    }
    
    func test_fetchPokemon_whenFailure_callsDelegateWithError() {
        let error = NSError(domain: "TestError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Yes, should fail"])
        mockPokemonService.pokemonDetailResult = .failure(error)
        
        sut.fetchPokemonDetail()
        
        XCTAssertTrue(mockDelegate.didFailToFetchPokemonDetailCalled)
        XCTAssertEqual(mockDelegate.messageError, "Yes, should fail")
    }
    
}
