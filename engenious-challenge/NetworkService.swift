//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

struct RepositoryService {

	func getUserRepos(username: String) -> Future<[Repo], Error> {
		return Future { promise in
			guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
				promise(.failure(URLError(.badURL)))
				return
			}
			
			let session = URLSession.shared
			let request = URLRequest(url: url)
			let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
				
				if let error {
					promise(.failure(error))
					return
				}
				
				guard let data else {
					promise(.failure(URLError(.zeroByteResource)))
					return
				}
				
				do {
					let decoder = JSONDecoder()
						decoder.keyDecodingStrategy = .convertFromSnakeCase
					let response = try decoder.decode([Repo].self, from: data)
					promise(.success(response))
				} catch {
					promise(.failure(error))
				}
			})
			task.resume()	
		}
	}
	
}
