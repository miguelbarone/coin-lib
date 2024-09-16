//
//  CoinLibUITests.swift
//  CoinLibUITests
//
//  Created by Miguel Barone on 11/09/24.
//

import XCTest

final class CoinLibUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["UI-TESTING"]
        app.launchEnvironment["/exchanges"] = exchangesJSON
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testOpenDetailsScreen() {
        let tableView = app.tables["listTableView"]
        XCTAssertTrue(tableView.exists)

        let firstTableViewCell = tableView.cells.firstMatch
        XCTAssertTrue(firstTableViewCell.exists)

        firstTableViewCell.tap()

        XCTAssertTrue(app.navigationBars["Detalhes"].exists)
    }

    func testOpenSafariWebsite() {
        let tableView = app.tables["listTableView"]
        XCTAssertTrue(tableView.exists)

        let firstTableViewCell = tableView.cells.firstMatch
        XCTAssertTrue(firstTableViewCell.exists)

        firstTableViewCell.tap()

        XCTAssertTrue(app.navigationBars["Detalhes"].exists)

        let websiteButton = app.buttons["websiteButton"]
        XCTAssertTrue(websiteButton.exists)

        websiteButton.tap()

        XCTAssertTrue(app.navigationBars["Website"].exists)
    }

    func testExchangeRequestFailure() {
        app.launchEnvironment["/exchanges"] = ""
        app.launch()

        let errorView = app.otherElements["errorView"]
        XCTAssertTrue(errorView.exists)
    }
}

let exchangesJSON = """
[
  {
    "exchange_id": "BINANCE",
    "website": "https://www.binance.com/",
    "name": "Binance",
    "data_quote_start": "2017-12-18T00:00:00.0000000Z",
    "data_quote_end": "2024-09-08T00:00:00.0000000Z",
    "data_orderbook_start": "2017-12-18T21:50:58.3910192Z",
    "data_orderbook_end": "2023-07-07T00:00:00.0000000Z",
    "data_trade_start": "2017-07-14T00:00:00.0000000Z",
    "data_trade_end": "2024-09-08T00:00:00.0000000Z",
    "data_symbols_count": 2748,
    "volume_1hrs_usd": 0,
    "volume_1day_usd": 0,
    "volume_1mth_usd": 0
  },
  {
    "exchange_id": "KRAKEN",
    "website": "https://www.kraken.com/",
    "name": "Kraken",
    "data_quote_start": "2014-07-31T00:00:00.0000000Z",
    "data_quote_end": "2024-09-08T00:00:00.0000000Z",
    "data_orderbook_start": "2014-07-31T13:05:46.0000000Z",
    "data_orderbook_end": "2023-07-06T00:00:00.0000000Z",
    "data_trade_start": "2013-10-22T00:00:00.0000000Z",
    "data_trade_end": "2024-09-08T00:00:00.0000000Z",
    "data_symbols_count": 978,
    "volume_1hrs_usd": 6105.5,
    "volume_1day_usd": 1667709.6,
    "volume_1mth_usd": 56258346.94
  }
]
"""
