//
//  ExchangeModel+Mocks.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib

extension ExchangeModel {
    static func mock() -> Self {
        ExchangeModel(
            exchangeId: "test-id",
            volume1HrsUsd: 100.0,
            volume1DayUsd: 200.0,
            volume1MthUsd: 300.0,
            name: "test",
            website: "https://test.com"
        )
    }
}
