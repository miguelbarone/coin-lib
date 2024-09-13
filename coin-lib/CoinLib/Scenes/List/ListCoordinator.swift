//
//  ListCoordinator.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation

protocol ListCoordinating: AnyObject {
    func pushDetailsScreen(with exchange: ExchangeViewModel)
}

final class ListCoordinator: ListCoordinating {
    func pushDetailsScreen(with exchange: ExchangeViewModel) {
        
    }
}
