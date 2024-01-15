//
//  engenious_challengeUITests.swift
//  engenious-challengeUITests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
import Combine
@testable import engenious_challenge

class engenious_challengeUITests: XCTestCase {
    class MockNetworking: NetworkingProtocol{
        var shouldReturnError = false
        var mockedData: [Repo]?
        
        func getUserRepos(username: String, completion: @escaping ([engenious_challenge.Repo]) -> Void) {
            if shouldReturnError {
                completion([])
            } else {
                completion([Repo(name: "Name", description: "Description", url: "URL")])
            }
        }
        
        func getUserRepos(username: String) -> AnyPublisher<[engenious_challenge.Repo], Error> {
            if shouldReturnError {
                let error = NSError(domain:"https://api.github.com/users/\(username)/repos", code: 42, userInfo: nil)
                return Fail(error: error)
                    .eraseToAnyPublisher()
                
            } else {
                guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
                    let error = NSError(domain: "https://api.github.com/users/\(username)/repos", code: 42, userInfo: nil)
                    return Fail(error: error)
                        .eraseToAnyPublisher()
                }
                
                let request = URLRequest(url: url)
                
                return URLSession.shared
                    .dataTaskPublisher(for: request)
                    .tryMap { result -> [engenious_challenge.Repo] in
                        let decoder = JSONDecoder()
                        return try decoder.decode([engenious_challenge.Repo].self, from: result.data)
                    }
                    .eraseToAnyPublisher()
            }
        }
    }
    
    var sut: NetworkService!
    var mockNetworking: MockNetworking!
    let username = "Apple"
    var storage = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        sut = NetworkService()
        mockNetworking = MockNetworking()
    }
    
    override func tearDown() {
        sut = nil
        mockNetworking = nil
        super.tearDown()
    }
    
    /// sinple request
    func testFetchingDataSuccessfully() {
        let expectedData = [Repo(name: "Name", description: "Description", url: "URL")]
        mockNetworking.mockedData = expectedData
        
        var actualData: [Repo]?
        sut.getUserRepos(username: username) { data in
            actualData = data
        }
        
        XCTAssertEqual(actualData, expectedData)
    }
    
    func testFetchingDataWithError() {
        mockNetworking.shouldReturnError = true
        
        var actualData: [Repo]?
        sut.getUserRepos(username: username) { data in
            actualData = data
        }
        
        XCTAssertNotNil((actualData == nil))
    }
    
    /// combine request
    func testFetchingDataWithCombine() {
        let expectedData = [Repo(name: "Name", description: "Description", url: "URL")]
        mockNetworking.mockedData = expectedData
        
        var actualData: [Repo]?
        var receivedError: Error?
        sut.getUserRepos(username: username)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        receivedError = error
                    case .finished:
                        break
                    }},
                receiveValue: { data in
                    actualData = data
                })
            .store(in: &storage)
        
        XCTAssertEqual(actualData, expectedData)
        XCTAssertNotNil(receivedError)
    }
}
