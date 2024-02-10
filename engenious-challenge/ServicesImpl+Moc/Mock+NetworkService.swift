//
//  Mock+NetworkService.swift
//  engenious-challenge
//
//  Created by Eugene Garkavenko on 10.02.2024.
//

import Combine
import Foundation

final class MockNetworkServiceCombine: NetworkServiceCombine {
    func fetchData(with url: URL) -> URLSession.DataTaskPublisher {
        switch url {
        case Endpoint.usersRepos(username: "validData").url:
            let testData = """
            [
              {
                "name": "TestRepo",
                "description": "A test repository",
                "url": "https://github.com/testUser/TestRepo"
              }
            ]
            """.data(using: .utf8)!
            
            URLProtocolMock.testURLs = [url: testData]
            URLProtocolMock.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        case Endpoint.usersRepos(username: "invalidData").url:
            let testData = """
            [
              "Invalid Data"
            ]
            """.data(using: .utf8)!
            
            URLProtocolMock.testURLs = [url: testData]
            URLProtocolMock.response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        case Endpoint.usersRepos(username: "statusCode404").url:
            let testData = """
            """.data(using: .utf8)!
            
            URLProtocolMock.testURLs = [url: testData]
            URLProtocolMock.response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)
        default:
            break
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        return session.dataTaskPublisher(for: URLRequest(url: url))
    }
}

@objc
final class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()
    static var response: URLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url] {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        
        if let response = URLProtocolMock.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLProtocolMock.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    }
}
