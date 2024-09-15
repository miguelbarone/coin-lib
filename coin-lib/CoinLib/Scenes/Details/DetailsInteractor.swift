//
//  DetailsInteractor.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol DetailsInteracting: AnyObject {
    func initialSetup()
    func openWebsite()
}

final class DetailsInteractor: DetailsInteracting {
    private let presenter: DetailsPresenting
    private let exchange: ExchangeViewModel

    init(presenter: DetailsPresenting, exchange: ExchangeViewModel) {
        self.presenter = presenter
        self.exchange = exchange
    }

    func initialSetup() {
        presenter.presentLayout(with: exchange)
    }

    func openWebsite() {
        presenter.presentWebsite(urlString: exchange.website)
    }
}
