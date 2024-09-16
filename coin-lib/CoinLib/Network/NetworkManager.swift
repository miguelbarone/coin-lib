//
//  NetworkManager.swift
//  CoinLib
//
//  Created by Miguel Barone on 12/09/24.
//

import Foundation

enum API {
    static let baseURL = "https://rest.coinapi.io/v1"
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError(description: String)
    case requestError(description: String)
    case invalidEnvironment
}

protocol NetworkProtocol {
    func execute<T: Decodable>(with request: Request, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkProtocol {
    private let API_KEY = ""

    let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func execute<T: Decodable>(with request: Request, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: API.baseURL + request.endpoint)
        let isUITesting = ProcessInfo().arguments.contains("UI-TESTING")

        if isUITesting {
            return executeJSON(endpoint: request.endpoint, completion: completion)
        }

        guard let url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addValue(API_KEY, forHTTPHeaderField: "Authorization")

        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.requestError(description: error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.decodingError(description: error.localizedDescription)))
            }
        }

        dataTask.resume()
    }
}

private extension NetworkManager {
    func executeJSON<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let json = ProcessInfo().environment[endpoint] else {
            completion(.failure(NetworkError.invalidEnvironment))
            return
        }

        guard let data = json.data(using: .utf8) else {
            completion(.failure(NetworkError.noData))
            return
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let result = try decoder.decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(NetworkError.decodingError(description: error.localizedDescription)))
        }
    }
}
