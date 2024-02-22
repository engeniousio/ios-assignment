//
//  engenious_challengeTests.swift
//  engenious-challengeTests
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import XCTest
@testable import engenious_challenge

class engenious_challengeTests: XCTestCase {
    
    var session: URLSession!
    var repositoryService: RepositoryService!
    
    override func setUpWithError() throws {
        session = URLSession(configuration: .default)
        repositoryService = RepositoryServiceImpl.makeDefault()
    }

    override func tearDownWithError() throws {
        session = nil
        repositoryService = nil
        super.tearDown()
    }
    
    func testEndpointURL() {
        let endpoint = Endpoint.repos(matching: "Apple")
        XCTAssertNotNil(endpoint.url)
    }
    
    func testUserEndpoint() throws {
        let endpoint = Endpoint.repos(matching: "Apple")
        
        XCTAssertEqual(endpoint.path, "/users/Apple/repos")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://api.github.com/users/Apple/repos")
    }

    func testFetchUserRepos() {
        let expectation = self.expectation(description: "Fetching user repos")
        let endpoint = Endpoint.repos(matching: "Apple")
        
        repositoryService.getUserRepos(endpoint: endpoint) { result in
            switch result {
            case .success(let repos):
                XCTAssertFalse(repos.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetching user repos failed with error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidURL() {
        let expectation = self.expectation(description: "Invalid URL")
        
        let endpoint = Endpoint(path: "invalid/path", queryItems: [])
        repositoryService.getUserRepos(endpoint: endpoint) { result in
            switch result {
            case .success:
                XCTFail("Request should fail with invalid URL")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testStatusCodeValidation() {
        let expectation = self.expectation(description: "Status Code Validation")
        let endpoint = Endpoint.repos(matching: "someUsername")
        
        let mockValidator = StatusCodeValidator()
        let httpResponse = HTTPURLResponse(url: endpoint.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        do {
            try mockValidator.validate(httpResponse)
            XCTFail("Status code validation should fail")
        } catch let error as ResponseValidationError {
            XCTAssertEqual(error, ResponseValidationError.unacceptableCode(404))
            expectation.fulfill()
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
