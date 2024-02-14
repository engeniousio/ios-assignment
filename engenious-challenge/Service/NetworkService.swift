//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol RepositoryServiceProtocol {
    func getUserRepos(username: String) -> AnyPublisher<[Repo], Error>
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void)
}

struct RepositoryService: RepositoryServiceProtocol {
    func getUserRepos(username: String) -> AnyPublisher<[Repo], Error> {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            return completion([])
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode([Repo].self, from: data)
                completion(response)
            } catch {

            }
        })
        task.resume()
    }
}
