//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
import Combine
@testable import engenious_challenge

class MockApiRequest: APIRequest {
    typealias Response = MockResponse

    var resourceName: String { "/test" }
    var method: HttpMethod { .get }

}

class MockResponse: Decodable {

}

class engenious_challengeTests: XCTestCase {

    private var builder: RequestBuilderProtocol!
    private var networkService: NetworkServiceProtocol!
    private var subscriptions: Set<AnyCancellable>!

    override func setUpWithError() throws {
        self.builder = RequestBuilder()
        self.networkService = NetworkService(baseUrl: URL(string: "https://api.github.com")!, requestBuilder: builder)
        self.subscriptions = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMakingRequest() throws {
        let url = URL(string: "https://apple.com")!
        let urlRequest = try builder.makeRequest(MockApiRequest(), baseURL: url)
        XCTAssertTrue(urlRequest.url?.scheme == "https")
        XCTAssertTrue(urlRequest.url?.path == "/test")
        XCTAssertTrue(urlRequest.url?.host == "apple.com")
    }

    func testApiRequestMethod() {
        var response: [Repo]?
        let expectation = expectation(description: "GitHub Response come")
        networkService.send(GetReposRequest(username: "Apple")) { repos, error in
            response = repos
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20)
        XCTAssertNotNil(response)

    }

    func testApiCombineMethod() {
        var response: [Repo]?
        var error: Error?
        let expectation = expectation(description: "GitHub Response come")
        networkService.send(GetReposRequest(username: "Apple"))
            .sink {
                switch $0 {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: {
                response = $0
            }.store(in: &subscriptions)

        waitForExpectations(timeout: 20)
        XCTAssertNil(error)
        XCTAssertNotNil(response)

    }
}
