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

    func execute<T: Decodable>(with request: Request, completion: @escaping (Result<T, Error>) -> Void) {
        guard let result = executeResult as? Result<T, Error> else {
            XCTFail("executeResult not implemented")
            return
        }
        completion(result)
    }
}
