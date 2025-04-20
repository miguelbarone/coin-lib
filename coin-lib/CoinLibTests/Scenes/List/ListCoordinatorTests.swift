//
//  ListCoordinatorTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class ListCoordinatorTests: XCTestCase {
    var coordinator: ListCoordinator!
    var navigationControllerSpy: NavigationControllerSpy!
    var viewController: UIViewController!

    override func setUp() {
        super.setUp()
        coordinator = ListCoordinator()
        navigationControllerSpy = NavigationControllerSpy()
        viewController = UIViewController()

        navigationControllerSpy.viewControllers = [viewController]
        coordinator.viewController = viewController
    }

    override func tearDown() {
        coordinator = nil
        navigationControllerSpy = nil
        viewController = nil
        super.tearDown()
    }

    func testPushDetailsScreen() {
        let exchangeViewModel = ExchangeModel.mock()

        coordinator.pushDetailsScreen(with: exchangeViewModel)

        XCTAssertEqual(navigationControllerSpy.viewControllers.count, 2)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is DetailsViewController)
    }
}
