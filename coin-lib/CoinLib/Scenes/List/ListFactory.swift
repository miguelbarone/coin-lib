//
//  ListFactory.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

enum ListFactory {
    static func make() -> UIViewController {
        let service = ListService()
        let coordinator = ListCoordinator()
        let presenter = ListPresenter(coordinator: coordinator)
        let interactor = ListInteractor(presenter: presenter, service: service)
        let viewController = ListViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
