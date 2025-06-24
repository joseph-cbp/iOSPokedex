//
//  PokemonServiceTest.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import XCTest
@testable import PokedexProject

final class PokemonServiceTest: XCTestCase {
    
    var sut: PokemonService!
    var mockNetworkClient: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        mockNetworkClient = MockNetworkManager()
        sut = PokemonService(networkManager: mockNetworkClient)
    }
    
    override func tearDown() {
        mockNetworkClient = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchPokemonList_whenSuccess_shouldReturnPokemonList() {
        let expectation = XCTestExpectation(description: "Fetch Pokemon List")
        let mockList = MockResponses.createMockPokemonResponse()
        mockNetworkClient.result = .success(mockList)
        
        sut.fetchPokemonList { result in
            switch result {
            case .success(let pokemons):
                XCTAssertEqual(pokemons.count, 2)
                XCTAssertEqual(pokemons[0].name, "Bulbasaur")
                XCTAssertEqual(pokemons[1].name, "Ivysaur")
                expectation.fulfill()
            case .failure:
                XCTFail("Should not fail")
                
            }
        }
    }
}
