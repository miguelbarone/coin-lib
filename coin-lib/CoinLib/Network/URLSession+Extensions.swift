//
//  URLSession+Extensions.swift
//  CoinLib
//
//  Created by Miguel Barone on 19/04/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
