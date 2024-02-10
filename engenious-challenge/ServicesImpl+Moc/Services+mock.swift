//
//  Services+mock.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation

extension Services {
    static var mock: Services {
        Services(
            networkServiceCombine: MockNetworkServiceCombine(),
            networkServiceCallback: URLSession.shared
        )
    }
}
