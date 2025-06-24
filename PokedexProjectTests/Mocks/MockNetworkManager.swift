//
//  MockNetworkManager.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import Foundation

@testable import PokedexProject

class MockNetworkManager: NetworkManagerProtocol {
    var result: Result<Decodable, Error>?
    var lastFetchedURL: String?
    
    func fetch<T>(from urlString: String, decodeTo type: T.Type, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        lastFetchedURL = urlString
        
        if let result = result {
            switch result {
            case .success(let decodable):
                if let value = decodable as? T {
                    completion(.success(value))
                } else {
                    let error = NSError(domain: "MockError", code: 422, userInfo: [NSLocalizedDescriptionKey: "Type mismatch"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "No result set on mock"])
            completion(.failure(error))
        }
    }
    
    
}
