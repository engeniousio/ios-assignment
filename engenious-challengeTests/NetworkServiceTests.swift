//
//  NetworkServiceTests.swift
//  engenious-challengeTests
//
//  Created by Misha Dovhiy on 09.01.2024.
//

import XCTest
@testable import engenious_challenge

class NetworkServiceTests:XCTestCase {
    
    private let model = RepositoryService()
    
    func testUrlEqual() async {
        let expectation = XCTestExpectation(description: "Data should not be need, Error should be nill")
        let response = await model.getRepositories(username: "mishadovhiy")
        XCTAssertNotNil(response.data, "Data should not be nil")
        XCTAssertNil(response.error, "Error should be nil")
    }
}
