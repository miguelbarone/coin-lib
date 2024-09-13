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
    private let presenter: ListPresenting
    private let service: ListServicing

    init(presenter: ListPresenting, service: ListServicing) {
        self.presenter = presenter
        self.service = service
    }

    func fetchData() {
        presenter.showLoading()

        service.getExchanges { [weak self] result in
            guard let self else { return }

            presenter.hideLoading()

            switch result {
            case let .success(response):
                presenter.presentItems(response)
            case .failure:
                presenter.presentErrorView()
            }
        }
    }
}
