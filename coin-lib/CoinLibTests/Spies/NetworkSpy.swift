//
//  NetworkSpy.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

class NetworkSpy: NetworkProtocol {
    var executeResult: Result<[ExchangeModel], Error>?
    private(set) var fetchResult: Data?
    private(set) var fetchError: Error?

    func execute<T: Decodable>(with request: Request, completion: @escaping (Result<T, Error>) -> Void) {
        guard let result = executeResult as? Result<T, Error> else {
            XCTFail("executeResult not implemented")
            return
        }
        completion(result)
    }

    func fetch<T: Decodable>(request: Request) async throws -> T {
        if let fetchError {
            throw fetchError
        }

        if let fetchResult {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(T.self, from: fetchResult)
            return decodedResponse
        }

        throw NetworkError.noData
    }

    func setResult<T: Codable>(_ data: T) {
        let encoder = JSONEncoder()

        do {
            fetchResult = try encoder.encode(data)
        } catch {
            fetchResult = nil
        }
    }

    func setError(_ error: Error) {
        fetchError = error
    }
}
