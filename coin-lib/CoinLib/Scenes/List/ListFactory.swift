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
        let presenter = ListPresenter()
        let interactor = ListInteractor(presenter: presenter, service: service)
        let viewController = ListViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
