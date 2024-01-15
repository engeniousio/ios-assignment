//
//  NetworkingProtocol.swift
//  engenious-challenge
//
//  Created by admin on 15.01.2024.
//

import Foundation
import Combine


protocol NetworkingProtocol {
    func getUserRepos(username: String, completion: @escaping ([Repo]) -> Void)
    func getUserRepos(username: String) -> AnyPublisher<[Repo], Error>
}
