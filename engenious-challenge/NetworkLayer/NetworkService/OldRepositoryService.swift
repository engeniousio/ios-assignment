//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

struct OldRepositoryService {
    
    func getUsersRepositories(reporitoryDTO: RepositoryDTO,
                          request: NetworkRequest,
                          completion: @escaping (Result<[Repository], NetworkError>) -> Void) {
            let endpoint = Endpoints.getUsersRepos(request: reporitoryDTO)
            let request = endpoint.createRequest()
            let session = URLSession.shared
            guard let url = URL(string: request.url) else {
                completion(.failure(.badURL("Could`nt create URL")))
                return
            }
            let urlRequest = URLRequest(url: url)
            
            let task = session.dataTask(with: urlRequest) { data, response, error in
                guard error == nil else {
                    completion(.failure(.apiError(code: 1, error: error.debugDescription )))
                    return
                }
                
                guard let data = data else {
                        completion(.failure(.apiError(code: 2, error: "No data")))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode([Repository].self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.invalidJSON("Invalid JSON")))
                }
            }
            task.resume()
        }
}
