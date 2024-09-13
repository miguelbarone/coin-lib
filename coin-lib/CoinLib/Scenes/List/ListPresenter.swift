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
    func presentErrorView()
}

final class ListPresenter: ListPresenting {
    weak var viewController: ListDisplaying?

    func showLoading() {
        viewController?.showLoading()
    }

    func hideLoading() {
        viewController?.hideLoading()
    }

    func presentItems(_ exchangesModel: [ExchangeModel]) {
        viewController?.displayExchanges(mapToViewModel(exchangesModel))
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
