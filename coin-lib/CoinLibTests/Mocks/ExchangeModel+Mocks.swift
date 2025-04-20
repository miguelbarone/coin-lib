//
//  ExchangeViewModel+Mocks.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib

extension ExchangeModel {
    static func mock(website: String? = "https://test.com") -> Self {
        ExchangeModel(
            hash: "1",
            name: "test",
            id: "test-id",
            value: "US$ 200,00",
            website: website
        )
    }
}
