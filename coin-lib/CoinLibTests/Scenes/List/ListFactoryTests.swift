//
//  ListFactoryTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

import XCTest
@testable import CoinLib

class ListFactoryTests: XCTestCase {
    func testMake() {
        let viewController = ListFactory.make()

        XCTAssertTrue(viewController is ListViewController)
    }
}
