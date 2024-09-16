//
//  DetailsInteractorTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class DetailsPresentingSpy: DetailsPresenting {
    enum Message: Equatable {
        case presentLayout(exchange: ExchangeViewModel)
        case presentWebsite(urlString: String?)
    }

    private(set) var messages = [Message]()

    func presentLayout(with exchange: ExchangeViewModel) {
        messages.append(.presentLayout(exchange: exchange))
    }

    func presentWebsite(urlString: String?) {
        messages.append(.presentWebsite(urlString: urlString))
    }
}

final class DetailsInteractorTests: XCTestCase {
    var presenterSpy: DetailsPresentingSpy!
    var interactor: DetailsInteractor!

    override func setUp() {
        super.setUp()
        presenterSpy = DetailsPresentingSpy()
        interactor = DetailsInteractor(presenter: presenterSpy, exchange: ExchangeViewModel.mock())
    }

    override func tearDown() {
        presenterSpy = nil
        interactor = nil
        super.tearDown()
    }

    func testInitialSetup_ShouldPresentLayoutWithExchangeInfos() {
        let exchange = ExchangeViewModel.mock()

        interactor.initialSetup()

        XCTAssertEqual(presenterSpy.messages, [.presentLayout(exchange: exchange)])
    }

    func testOpenWebsite_ShouldPresentWebsiteWithExchangeWebsiteURL() {
        let exchange = ExchangeViewModel.mock()

        interactor.openWebsite()

        XCTAssertEqual(presenterSpy.messages, [.presentWebsite(urlString: exchange.website)])
    }
}
