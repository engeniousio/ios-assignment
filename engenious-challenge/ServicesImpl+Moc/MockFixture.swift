//
//  MockFixture.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Foundation

func mockFixture(name: String) -> Data {
    guard let mockFixturesURL = Bundle.main.url(forResource: name, withExtension: "json"),
          let data = try? Data(contentsOf: mockFixturesURL) else {
        fatalError("Mock fixture \(name) not found.")
    }
    
    return data
}
