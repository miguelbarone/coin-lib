//
//  ListCoordinator.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

protocol ListCoordinating: AnyObject {
    func pushDetailsScreen(with exchange: ExchangeModel)
}

final class ListCoordinator: ListCoordinating {
    weak var viewController: UIViewController?

    func pushDetailsScreen(with exchange: ExchangeModel) {
        let detailsViewController = DetailsFactory.make(exchange: exchange)
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
