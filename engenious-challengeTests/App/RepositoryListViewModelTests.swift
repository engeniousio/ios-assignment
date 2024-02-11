//
//  RepositoryListViewModelTests.swift
//  engenious-challengeTests
//
//  Created by Volodymyr Mykhailiuk on 11.02.2024.
//

import XCTest
import Combine
@testable import engenious_challenge

final class RepositoryListViewModelTests: XCTestCase {
    var viewModel: RepositoryListViewModel!
    var repositoryService: MockRepositoryService!
    var cancellables: Set<AnyCancellable>!
    let repositories = [
        RepoDataModel(name: "Repo1", description: "Description1", url: "URL1"),
        RepoDataModel(name: "Repo1", description: "Description1", url: "URL1")
    ]
    
    override func setUp() {
        super.setUp()
        repositoryService = MockRepositoryService()
        repositoryService.repositories = repositories
        viewModel = RepositoryListViewModel(repositoryService: repositoryService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        repositoryService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testSetupSuccess() {
        // Given
        let expectedTitle = "\(viewModel.username)'s repos"
        let expectation1 = XCTestExpectation(
            description: "Setup method should update title"
        )
        let expectation2 = XCTestExpectation(
            description: "Setup method should load repositories"
        )
        
        // When
        viewModel.setup()
        
        viewModel.$navigationTitle
            .sink { title in
                // Then
                XCTAssertEqual(title, expectedTitle)
                expectation1.fulfill()
            }
            .store(in: &cancellables)
        viewModel.$listState
            .sink { result in
                // Then
                if case .loaded(let models) = result {
                    XCTAssertEqual(models.count, self.repositories.count)
                    expectation2.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation1, expectation2], timeout: 2.0)
    }
    
    func testSetupFailed() {
        // Given
        let expectation = XCTestExpectation(
            description: "Setup method should fail"
        )
        repositoryService.error = .invalidResponse
        
        // When
        viewModel.setup()
        
        viewModel.$listState
            .sink { state in
                if case .failed(let error) = state {
                    XCTAssertEqual(error, .invalidResponse)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testRefreshWithRefreshControl() {
        // Given
        let expectation = XCTestExpectation(
            description: "Refresh method should reload repositories with refreshing state"
        )
        
        // When
        viewModel.refresh(refreshControl: true)
        
        viewModel.$listState
            .sink { state in
                // Then
                XCTAssertEqual(state, .refreshing)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRefreshWithoutRefreshControl() {
        // Given
        let expectation = XCTestExpectation(
            description: "Refresh method should reload repositories with loading state"
        )
        
        // When
        viewModel.refresh(refreshControl: false)
        
        viewModel.$listState
            .sink { state in
                // Then
                XCTAssertEqual(state, .loading)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
