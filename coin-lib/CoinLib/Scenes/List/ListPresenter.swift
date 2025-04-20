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
    func presentItems(_ exchangesModel: [ExchangeResponse])
    func presentDetailsScreen(with exchange: ExchangeModel)
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

    func presentItems(_ exchangesModel: [ExchangeResponse]) {
        viewController?.displayExchanges(mapToViewModel(exchangesModel))
    }

    func presentDetailsScreen(with exchange: ExchangeModel) {
        coordinator.pushDetailsScreen(with: exchange)
    }

    func presentErrorView() {
        viewController?.displayErrorView()
    }
}

private extension ListPresenter {
    func mapToViewModel(_ models: [ExchangeResponse]) -> [ExchangeModel] {
        models.enumerated().map { index, model -> ExchangeModel in
            ExchangeModel(
                hash: "\(index + 1)",
                name: model.name ?? Strings.Exchanges.defaultName,
                id: model.exchangeId,
                value: model.volume1DayUsd.formatted(.currency(code: Strings.usdCode)),
                website: model.website
            )
        }
    }
}
