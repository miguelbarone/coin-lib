//
//  DetailsCoordinator.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import SafariServices

protocol DetailsCoordinating: AnyObject {
    func openWebsite(url: URL)
}

final class DetailsCoordinator: DetailsCoordinating {
    weak var viewController: UIViewController?

    func openWebsite(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        viewController?.navigationController?.pushViewController(safariViewController, animated: true)
    }
}
