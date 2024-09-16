//
//  ListFactoryTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class ListFactoryTests: XCTestCase {
    func testMake_ShouldReturnListViewController() {
        let viewController = ListFactory.make()

        XCTAssertTrue(viewController is ListViewController)
    }
}
