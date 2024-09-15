//
//  DetailsPresenter.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol DetailsPresenting: AnyObject {
    func presentLayout(with exchange: ExchangeViewModel)
    func presentWebsite(urlString: String?)
}

final class DetailsPresenter: DetailsPresenting {
    private let coordinator: DetailsCoordinating

    weak var viewController: DetailsDisplaying?

    init(coordinator: DetailsCoordinating) {
        self.coordinator = coordinator
    }

    func presentLayout(with exchange: ExchangeViewModel) {
        viewController?.displayName(exchange.name, id: exchange.id)

        if exchange.website != nil {
            viewController?.displayWebsiteButton()
        }
    }

    func presentWebsite(urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else { return }
        coordinator.openWebsite(url: url)
    }
}
