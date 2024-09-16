//
//  NavigationControllerSpy.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    private(set) var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: false)
    }
}
