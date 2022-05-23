import Foundation

// MARK: - URLService

final class URLService: URLServiceProtocol {
    
    func makeRequest<T>(
        with urlRequest: URLRequest,
        responseType: T.Type,
        completion: @escaping (T) -> Void
    ) where T : Decodable {
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(T.self, from: data)
                completion(response)
            } catch let error {
                print(error)
            }
        })
        task.resume()
    }
    
    func makeRequest<T>(
        with urlRequest: URLRequest,
        responseType: T.Type
    ) -> RequestPublisher<T> where T : Decodable {
        URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
