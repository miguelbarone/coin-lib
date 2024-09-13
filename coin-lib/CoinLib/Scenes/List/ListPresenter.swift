//
//  ListPresenter.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol ListPresenting: AnyObject {
    func showLoading()
    func hideLoading()
    func presentItems(_ exchangesModel: [ExchangeModel])
    func presentDetailsScreen(with exchange: ExchangeViewModel)
    func presentErrorView()
}

final class ListPresenter: ListPresenting {
    private let coordinator: ListCoordinating

    weak var viewController: ListDisplaying?

    init(coordinator: ListCoordinating) {
        self.coordinator = coordinator
    }

    func showLoading() {
        viewController?.showLoading()
    }

    func hideLoading() {
        viewController?.hideLoading()
    }

    func presentItems(_ exchangesModel: [ExchangeModel]) {
        viewController?.displayExchanges(mapToViewModel(exchangesModel))
    }

    func presentDetailsScreen(with exchange: ExchangeViewModel) {
        coordinator.pushDetailsScreen(with: exchange)
    }

    func presentErrorView() {
        viewController?.displayErrorView()
    }
}

private extension ListPresenter {
    func mapToViewModel(_ models: [ExchangeModel]) -> [ExchangeViewModel] {
        models.enumerated().map { index, model -> ExchangeViewModel in
            ExchangeViewModel(
                hash: "\(index + 1)",
                name: model.name ?? Strings.Exchange.defaultName,
                id: model.exchangeId,
                value: model.volume1DayUsd.formatted(.currency(code: Strings.usdCode)),
                website: model.website
            )
        }
    }
}
