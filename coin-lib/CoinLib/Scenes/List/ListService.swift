//
//  ListService.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol ListServicing: AnyObject {
    func getExchanges() async throws -> [ExchangeResponse]
}

final class ListService: ListServicing {
    let network: NetworkProtocol

    init(network: NetworkProtocol = NetworkManager()) {
        self.network = network
    }

    func getExchanges() async throws -> [ExchangeResponse] {
        do {
            let request = ListRequest.getExchanges()
            let response: [ExchangeResponse] = try await network.fetch(request: request)
            return response
        } catch {
            throw error
        }
    }
}
