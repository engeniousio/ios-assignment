//
//  RepositoryServiceTests.swift
//  engenious-challengeTests
//
//  Created by Eugene Fozekosh on 14.02.2024.
//

import XCTest
import Combine
@testable import engenious_challenge

class RepositoryServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testGetUserReposSuccess() {
        // Arrange
        let service = MockRepositoryService(result: .success([Repo(name: "TestRepo", description: "A test repo", url: "https://api.github.com/repos/test")]))
        let expectation = XCTestExpectation(description: "Fetch user repos")

        // Act
        service.getUserRepos(username: "testuser")
            .sink(receiveCompletion: { completion in
                // Assert
                switch completion {
                case .finished:
                    break
                case .failure:
                    XCTFail("The call to getUserRepos finished with an error.")
                }
                expectation.fulfill()
            }, receiveValue: { repos in
                // Assert
                XCTAssertEqual(repos.count, 1)
                XCTAssertEqual(repos.first?.name, "TestRepo")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUserReposFailure() {
        // Arrange
        let service = MockRepositoryService(result: .failure(URLError(.badServerResponse)))
        // Act
        service.getUserRepos(username: "testuser") { repos in
            // Assert
            XCTAssertTrue(repos.isEmpty)
        }
    }

    func testMakeURLForUsername() {
        // Arrange
        let service = RepositoryService()
        let username = "testuser"

        // Act
        let url = service.makeURL(forUsername: username)

        // Assert
        XCTAssertEqual(url?.absoluteString, "https://api.github.com/users/testuser/repos")
    }

    func testGetUserReposWithEmptyUsername() {
        // Arrange
        let service = MockRepositoryService(result: .success([])) // Assuming success but empty result
        let expectation = XCTestExpectation(description: "Handle empty username")

        // Act
        service.getUserRepos(username: "") { repos in
            // Assert
            XCTAssertTrue(repos.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUserReposWithInvalidJSON() {
        // Arrange
        let service = MockRepositoryService(result: .failure(DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "The data couldn’t be read because it isn’t in the correct format."))))
        let expectation = XCTestExpectation(description: "Fetch user repos with invalid JSON")

        // Act
        service.getUserRepos(username: "testuser")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure but got success")
                case .failure(let error):
                    // Assert
                    guard case DecodingError.dataCorrupted(_) = error else {
                        return XCTFail("Expected decoding error")
                    }
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Expected to fail but succeeded")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
