//
//  NetworkManagerProtocol.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

import Combine
import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func fetch<T: Decodable>(
        from urlString: String,
        decodeTo type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
    func fetchWithCombine<T: Decodable>(_ url: URL, type: T.Type) -> AnyPublisher<T, Error>
}
