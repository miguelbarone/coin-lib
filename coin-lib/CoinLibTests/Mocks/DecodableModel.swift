//
//  DecodableModel.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

import Foundation

struct DecodableModel: Decodable {
    let id: Int
    let name: String

    static let json = "{\"id\": 1, \"name\": \"Test\"}"
}
