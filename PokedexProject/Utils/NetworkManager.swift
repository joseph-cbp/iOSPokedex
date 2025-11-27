//
//  NetworkManager.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 06/06/25.
//

import Foundation
import Combine

class NetworkManager: NetworkManagerProtocol {
    
    func fetch<T: Decodable>(
        from urlString: String,
        decodeTo type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(ServiceError.emptyData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchWithCombine<T: Decodable>(_ url: URL, type: T.Type) -> AnyPublisher<T, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError {$0 as Error}
            .decode(type: type, decoder: JSONDecoder())
            .eraseToAnyPublisher( )
        
    }
}

enum ServiceError: Error {
    case invalidURL
    case emptyData
}
