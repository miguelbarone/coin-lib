//
//  DetailsCoordinatorTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import SafariServices
import XCTest

class DetailsCoordinatorTests: XCTestCase {
    var coordinator: DetailsCoordinator!
    var navigationControllerSpy: NavigationControllerSpy!
    var viewController: UIViewController!

    override func setUp() {
        super.setUp()
        coordinator = DetailsCoordinator()
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

    func testOpenWebsite_ShouldPushSFSafariViewController() throws {
        let url = try XCTUnwrap(URL(string: "http://example.com"))

        coordinator.openWebsite(url: url)
        
        XCTAssertEqual(navigationControllerSpy.viewControllers.count, 2)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is SFSafariViewController)
    }
}
