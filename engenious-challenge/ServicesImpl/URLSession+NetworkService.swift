//
//  URLSession+NetworkService.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation
import Combine

extension URLSession: NetworkServiceCombine {
    func fetchData(with url: URL) -> DataTaskPublisher {
        dataTaskPublisher(for: url)
    }
}

extension URLSession: NetworkServiceCallback {
    func fetchData(with url: URL, completion: @escaping (Result<(URLResponse, Data), Error>) -> Void) {
        let task = dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response, let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success((response, data)))
        }
        
        task.resume()
    }
}
