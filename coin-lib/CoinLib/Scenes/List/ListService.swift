//
//  ListService.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol ListServicing: AnyObject {
    func getExchanges(completion: @escaping (Result<[ExchangeModel], Error>) -> Void)
}

final class ListService: ListServicing {
    let network: NetworkProtocol

    init(network: NetworkProtocol = NetworkManager()) {
        self.network = network
    }

    func getExchanges(completion: @escaping (Result<[ExchangeModel], Error>) -> Void) {
        let request = ListRequest.getExchanges()

        network.execute(with: request) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
