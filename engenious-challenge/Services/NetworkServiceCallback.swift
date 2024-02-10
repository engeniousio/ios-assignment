//
//  NetworkServiceCallback.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation

protocol NetworkServiceCallback {
    func fetchData(with url: URL, completion: @escaping (Result<(URLResponse, Data), Error>) -> Void)
}
