//
//  File.swift
//  engenious-challenge
//
//  Created by Юлія Воротченко on 11.01.2024.
//

import Combine
import Foundation

public class Request: Requestable {
    public var requestTimeOut: Float = 30

    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
     where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
         
        // We use the dataTaskPublisher from the URLSession
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                if let dataDict = try? JSONSerialization.jsonObject(with: output.data, options: []) as? [String: Any] {
                    printIfDebug("responseData: \(String(describing: dataDict))")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
        print(string)
    #endif
}
