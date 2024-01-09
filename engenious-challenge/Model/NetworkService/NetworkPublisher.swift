//
//  NetworkPublisher.swift
//  engenious-challenge
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import Foundation
import Combine

struct NetworkPublisher {
    static var response = PassthroughSubject<ServerResponse, Never>()
    static var cancellableHolder = Set<AnyCancellable>()
}
