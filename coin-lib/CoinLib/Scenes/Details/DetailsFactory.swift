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
        DetailsViewController()
    }
}
