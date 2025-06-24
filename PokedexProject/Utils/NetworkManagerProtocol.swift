//
//  NetworkManagerProtocol.swift
//  PokedexProject
//
//  Created by Joseph Pereira on 24/06/25.
//

protocol NetworkManagerProtocol: AnyObject {
    func fetch<T: Decodable>(
        from urlString: String,
        decodeTo type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
