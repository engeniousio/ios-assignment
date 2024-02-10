//
//  Services+init.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation

extension Services {
    init() {
        self.init(
            networkServiceCombine: URLSession.shared,
            networkServiceCallback: URLSession.shared
        )
    }
}
