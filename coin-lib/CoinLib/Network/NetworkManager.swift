//
//  NetworkManager.swift
//  CoinLib
//
//  Created by Miguel Barone on 12/09/24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError(description: String)
    case requestError(description: String)
    case invalidEnvironment
}

protocol NetworkProtocol {
    func fetch<T: Decodable>(request: Request) async throws -> T
}

final class NetworkManager: NetworkProtocol {
    private let urlSession: URLSessionProtocol

    private let isUITesting = ProcessInfo().arguments.contains("UI-TESTING")

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetch<T: Decodable>(request: Request) async throws -> T {
        guard let url = URL(string: Environment.baseURL + request.endpoint) else {
            throw NetworkError.invalidURL
        }

        if isUITesting {
            return try executeJSON(endpoint: request.endpoint)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addValue(Environment.apiKey, forHTTPHeaderField: "Authorization")

        let (data, response) = try await urlSession.data(for: urlRequest)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.requestError(description: "Unexpected error: \(response.statusCode)")
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let resultObject = try decoder.decode(T.self, from: data)
            return resultObject
        } catch {
            throw NetworkError.decodingError(description: error.localizedDescription)
        }
    }
}

private extension NetworkManager {
    func executeJSON<T: Decodable>(endpoint: String) throws -> T {
        guard let json = ProcessInfo().environment[endpoint] else {
            throw NetworkError.invalidEnvironment
        }

        guard let data = json.data(using: .utf8) else {
            throw NetworkError.noData
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw error
        }
    }
}
