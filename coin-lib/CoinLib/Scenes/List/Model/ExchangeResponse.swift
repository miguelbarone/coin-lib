//
//  ExchangeModel.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

struct ExchangeResponse: Codable, Equatable {
    let exchangeId: String
    let volume1HrsUsd, volume1DayUsd, volume1MthUsd: Double
    let name: String?
    let website: String?
}
