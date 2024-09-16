//
//  DetailsFactoryTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class DetailsFactoryTests: XCTestCase {
    func testMake_ShouldReturnDetailsViewController() {
        let viewController = DetailsFactory.make(exchange: ExchangeViewModel.mock())

        XCTAssertTrue(viewController is DetailsViewController)
    }
}
