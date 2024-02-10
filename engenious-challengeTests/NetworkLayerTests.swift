//
//  NetworkLayerTests.swift
//  engenious-challengeTests
//
//  Created by Volodymyr Mykhailiuk on 10.02.2024.
//

import XCTest
import Combine
@testable import engenious_challenge

final class NetworkLayerTests: XCTestCase {
    
    var urlSession: URLSession!
    var networkLayer: NetworkLayerProtocol!
    let reqURL = URL(string: "https://api.thecatapi.com/v1/images/search")!
    private var cancelable = Set<AnyCancellable>()
    
    private lazy var mockData: Data = {
        let mockString =
                 """
                    [
                        {
                            "name": "Foo",
                            "url": "https://google.com"
                        },
                        {
                            "name": "Bar",
                            "description": "FooBarBaz",
                            "url": "https://apple.com"
                        }
                    ]
                """
        return Data(mockString.utf8)
    }()
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        networkLayer = NetworkLayer(urlsession: urlSession)
    }
    
    func test_Fetch_Success() throws {
        // Given
        let response = HTTPURLResponse(
            url: reqURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )!
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        let expectation = XCTestExpectation(description: "response")
        let publisher: AnyPublisher<[RepoDataModel], ApiError> = networkLayer.fetch(config: .init(endpoint: "users/apple/repos"))
        
        // When
        publisher.sink { value in
            switch value {
            case .finished:
                expectation.fulfill()
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        } receiveValue: { models in
            // Then
            XCTAssertEqual(models.count, 2)
            XCTAssertEqual(models[0].name, "Foo")
            XCTAssertEqual(models[0].description, nil)
            XCTAssertEqual(models[0].url, "https://google.com")
            XCTAssertEqual(models[1].name, "Bar")
            XCTAssertEqual(models[1].description, "FooBarBaz")
            XCTAssertEqual(models[1].url, "https://apple.com")
        }
        .store(in: &cancelable)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_GetCat_BadRequest() throws {
        let response = HTTPURLResponse(
            url: reqURL,
            statusCode: 400,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )!
        
        MockURLProtocol.requestHandler = { request in
            return (response, self.mockData)
        }
        let expectation = XCTestExpectation(description: "response")
        let publisher: AnyPublisher<[RepoDataModel], ApiError> = networkLayer.fetch(config: .init(endpoint: "users/apple/repos"))
        
        // When
        publisher.sink { value in
            switch value {
            case .finished:
                XCTAssertThrowsError("Verify your preconditions")
            case .failure(let error):
                // Then
                XCTAssertEqual(ApiError.httpError(400), error)
                expectation.fulfill()
            }
        } receiveValue: { models in
            XCTAssertThrowsError("Verify your preconditions")
        }
        .store(in: &cancelable)
        
        wait(for: [expectation], timeout: 2)
    }
}
