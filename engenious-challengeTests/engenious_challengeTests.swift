//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
@testable import engenious_challenge

class RepositoryServiceMock: RepositoryServiceProtocol {
    var getUserReposCalled = false
    var completeWithSuccess: Bool = true
    var reposToReturn: [RepositoryModel] = []
    
    func getUserRepos(username: String, completion: @escaping (Result<[engenious_challenge.RepositoryModel], engenious_challenge.ErrorTypes>) -> Void) {
        getUserReposCalled = true
        if completeWithSuccess {
            completion(.success(reposToReturn))
        } else {
            completion(.failure(ErrorTypes.failureResponse("")))
        }
    }
}

class RepositoryViewModelTests: XCTestCase {

    var viewModel: RepositoryViewModel!
    var repositoryServiceMock: RepositoryServiceMock!

    override func setUp() {
        super.setUp()
        repositoryServiceMock = RepositoryServiceMock()
        viewModel = RepositoryViewModel(repositoryService: repositoryServiceMock)
    }

    override func tearDown() {
        viewModel = nil
        repositoryServiceMock = nil
        super.tearDown()
    }

    func testGetReposSuccess() {
        let expectedRepos = [RepositoryModel(name: "Repo1", description: "Description1", url: ""),
                             RepositoryModel(name: "Repo2", description: "Description2", url: "")]
        repositoryServiceMock.reposToReturn = expectedRepos

        let expectation = XCTestExpectation(description: "reloadCompletion called")
        
        viewModel.getRepos(username: "testUser") {
            XCTAssertEqual(self.viewModel.repoList, expectedRepos, "Repository list was not populated correctly on success")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(repositoryServiceMock.getUserReposCalled, "The getUserRepos method was not called on the repository service")
    }

    func testGetReposFailure() {
        repositoryServiceMock.completeWithSuccess = false

        let expectation = XCTestExpectation(description: "reloadCompletion called")
        
        viewModel.getRepos(username: "testUser") {
            XCTAssertTrue(self.viewModel.repoList.isEmpty, "Repository list should be empty on failure")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
