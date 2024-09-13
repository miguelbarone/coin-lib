//
//  ListRequest.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

struct ListRequest: Request {
    var method: HTTPMethod
    var endpoint: String

    static func getExchanges() -> Self {
        .init(method: .get, endpoint: "/exchanges")
    }
}
