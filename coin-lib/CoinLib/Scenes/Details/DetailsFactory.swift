//
//  DetailsFactory.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

enum DetailsFactory {
    static func make(exchange: ExchangeViewModel) -> UIViewController {
        let coordinator = DetailsCoordinator()
        let presenter = DetailsPresenter(coordinator: coordinator)
        let interactor = DetailsInteractor(presenter: presenter, exchange: exchange)
        let viewController = DetailsViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
