//
//  APIManager.swift
//  HW4
//
//  Created by Ян Козыренко on 08.07.2023.
//

import Moya

protocol APIManagerProtocol {
    func fetchData(completion: @escaping ((Result<CharacterModel, Error>) -> Void))
}

final class APIManager: APIManagerProtocol {
    let provider = MoyaProvider<APITarget>()
    
    func fetchData(completion: @escaping ((Result<CharacterModel, Error>) -> Void)) {
        request(target: .fetchData, completion: completion)
    }

}

private extension APIManager {
    func request<T: Decodable>(target: APITarget, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response) :
                do {
                    var decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let results = try decoder.decode(T.self, from: response.data)
                    completion(.success(results))
                }
                catch {
                    completion(.failure(error))
                }
            
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
