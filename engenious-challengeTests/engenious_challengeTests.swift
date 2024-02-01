//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
import Combine
@testable import engenious_challenge

class RootViewModelTests: XCTestCase {
    var repositoryServiceMock: RepositoryServiceMock!
    var rootViewModel: RootViewModel!

    override func setUp() {
        super.setUp()
        repositoryServiceMock = RepositoryServiceMock()
        rootViewModel = RootViewModel(repositoryService: repositoryServiceMock)
    }

    override func tearDown() {
        repositoryServiceMock = nil
        rootViewModel = nil
        super.tearDown()
    }

    func testFetchReposSuccess() {
        // When
        var completionCalled = false
        rootViewModel.fetchRepos(for: "test") {
            completionCalled = true
        }

        // Then
        XCTAssertTrue(completionCalled)
        XCTAssertEqual(rootViewModel.numberOfRepos, 2) // Assuming the mock returns 2 repos
    }

    func testFetchReposFailure() {
        // Given
        repositoryServiceMock.shouldSucceed = false // Simulate failure

        // When
        var completionCalled = false
        rootViewModel.fetchRepos(for: "test") {
            completionCalled = true
        }

        // Then
        XCTAssertTrue((rootViewModel.error != nil), "Error should be shown")
        XCTAssertTrue(completionCalled, "Completion handler should be called even on failure")
        XCTAssertEqual(rootViewModel.numberOfRepos, 0, "No repos should be added on failure")
    }

    func testFetchReposCombineSuccess() {
        // Simulate Combine success
        repositoryServiceMock.combinePublisher = Just([
            Repo(name: "Repo1", description: "Description1", url: "URL1"),
            Repo(name: "Repo2", description: "Description2", url: "URL2")
        ])
        .setFailureType(to: RepositoryService.ServiceError.self)
        .eraseToAnyPublisher()

        // When
        let expectation = self.expectation(description: "Fetch Repos Combine")
        rootViewModel.fetchReposCombine(for: "test") { result in
            switch result {
            case .success(let repos):
                // Then
                XCTAssertEqual(repos.count, 2)
            case .failure:
                XCTFail("Should not fail for this test case")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFetchReposCombineFailure() {
        // Simulate Combine failure
        repositoryServiceMock.combinePublisher = Fail(error: RepositoryService.ServiceError.networkError)
            .eraseToAnyPublisher()

        // When
        let expectation = self.expectation(description: "Fetch Repos Combine")
        rootViewModel.fetchReposCombine(for: "test") { result in
            switch result {
            case .success:
                XCTFail("Should not succeed for this test case")
            case .failure(let error):
                // Then
                XCTAssertEqual(error, .networkError)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
