//
//  ListInteractor.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol ListInteracting: AnyObject {
    func fetchData()
    func didSelectRow(exchange: ExchangeModel)
}

final class ListInteractor: ListInteracting {
    private let presenter: ListPresenting
    private let service: ListServicing

    init(presenter: ListPresenting, service: ListServicing) {
        self.presenter = presenter
        self.service = service
    }

    func fetchData() {
        Task {
            await fetchExchanges()
        }
    }

    func didSelectRow(exchange: ExchangeModel) {
        presenter.presentDetailsScreen(with: exchange)
    }
}

private extension ListInteractor {
    @MainActor
    func fetchExchanges() async {
        presenter.showLoading()

        do {
            let response = try await service.getExchanges()
            presenter.presentItems(response)
        } catch {
            presenter.presentErrorView()
        }

        presenter.hideLoading()
    }
}
