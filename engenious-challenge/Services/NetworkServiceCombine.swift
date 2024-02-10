//
//  NetworkService.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import Foundation
import Combine

protocol NetworkServiceCombine {
    func fetchData(with url: URL) -> URLSession.DataTaskPublisher
}

