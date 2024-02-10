//
//  NetworkServiceTests.swift
//  engenious-challengeTests
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Combine
import XCTest
@testable import engenious_challenge

class NetworkServiceTests: XCTestCase {
    var cancellablesBag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        cancellablesBag = []
    }
    
    override func tearDown() {
        URLProtocolMock.error = nil
        cancellablesBag = []
        super.tearDown()
    }
    
    func testFetchDataSuccess() {
        let services = Services.mock
        let expectation = XCTestExpectation(description: "Fetch data successfully")
        
        let url = Endpoint.usersRepos(username: "validData").url!
        
        services
            .networkServiceCombine
            .fetchData(with: url)
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Request failed with error: \(error)")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { repos in
                XCTAssertEqual(repos.count, 1, "Expected to receive one repo")
                XCTAssertEqual(repos.first?.name, "TestRepo", "Expected repo name to match")
            })
            .store(in: &cancellablesBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchDataNetworkError() {
        let services = Services.mock
        URLProtocolMock.error = URLError(.notConnectedToInternet)
        let expectation = XCTestExpectation(description: "Handle network error")
        
        let url = Endpoint.usersRepos(username: "validData").url!
        
        services
            .networkServiceCombine
            .fetchData(with: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if error.code == .notConnectedToInternet {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected a network error but received a different error")
                    }
                case .finished:
                    XCTFail("Expected to fail with network error, but finished successfully")
                }
            }, receiveValue: { _ in
                XCTFail("Expected to not receive any value")
            })
            .store(in: &cancellablesBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchDataWithInvalidData() {
        let services = Services.mock
        let url = Endpoint.usersRepos(username: "invalidData").url!
        
        let expectation = XCTestExpectation(description: "Handle invalid data error")
        
        services
            .networkServiceCombine
            .fetchData(with: url)
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [Repo].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected to fail due to invalid data, but finished successfully")
                }
            }, receiveValue: { _ in
                XCTFail("Expected not to receive any value")
            })
            .store(in: &cancellablesBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchDataWithHTTPError() {
        let services = Services.mock
        let url = Endpoint.usersRepos(username: "statusCode404").url!
        
        let expectation = XCTestExpectation(description: "Handle HTTP error response")
        
        services
            .networkServiceCombine
            .fetchData(with: url)
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    if let urlError = error as? URLError, urlError.code == .badServerResponse {
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected a HTTP error but received a different error")
                    }
                case .finished:
                    XCTFail("Expected to fail with HTTP error, but finished successfully")
                }
            }, receiveValue: { _ in
                XCTFail("Expected not to receive any value")
            })
            .store(in: &cancellablesBag)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
