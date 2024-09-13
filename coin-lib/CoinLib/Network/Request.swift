//
//  Request.swift
//  CoinLib
//
//  Created by Miguel Barone on 12/09/24.
//

import Foundation

protocol Request {
    var method: HTTPMethod { get }
    var endpoint: String { get }
}

enum HTTPMethod: String {
    case get = "GET"
}
