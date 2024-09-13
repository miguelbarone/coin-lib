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
        let interactor = ListInteractor(service: service)
        let viewController = ListViewController(interactor: interactor)

        return viewController
    }
}
