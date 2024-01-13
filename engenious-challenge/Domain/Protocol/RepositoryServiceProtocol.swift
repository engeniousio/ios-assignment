//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Foundation
import Combine

protocol RepositoryServiceProtocol {
    func repositories(request: RepositoryDTO) -> AnyPublisher<[Repository], NetworkError>
}
