//
//  ListInteractor.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol ListInteracting: AnyObject {
    func fetchData()
}

final class ListInteractor: ListInteracting {
    private let service: ListServicing

    init(service: ListServicing) {
        self.service = service
    }

    func fetchData() {
        service.getExchanges { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(response):
                print(response)
            case .failure:
                print("faio")
            }
        }
    }
}
