//
//  ExchangeViewModel+Mocks.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib

extension ExchangeViewModel {
    static func mock() -> Self {
        ExchangeViewModel(
            hash: "1",
            name: "test",
            id: "test-id",
            value: "US$ 200,00",
            website: "https://test.com"
        )
    }
}
