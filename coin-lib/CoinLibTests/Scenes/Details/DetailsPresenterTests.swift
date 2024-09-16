//
//  DetailsPresenterTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class DetailsDisplayingSpy: DetailsDisplaying {
    enum Message: Equatable {
        case displayName(name: String, id: String)
        case displayWebsiteButton
    }

    private(set) var messages = [Message]()

    func displayName(_ name: String, id: String) {
        messages.append(.displayName(name: name, id: id))
    }

    func displayWebsiteButton() {
        messages.append(.displayWebsiteButton)
    }
}

final class DetailsCoordinatingSpy: DetailsCoordinating {
    enum Message: Equatable {
        case openWebsite(url: URL)
    }

    private(set) var messages = [Message]()

    func openWebsite(url: URL) {
        messages.append(.openWebsite(url: url))
    }
}

final class DetailsPresenterTests: XCTestCase {
    var coordinatorSpy: DetailsCoordinatingSpy!
    var viewControllerSpy: DetailsDisplayingSpy!
    var presenter: DetailsPresenter!

    override func setUp() {
        super.setUp()
        coordinatorSpy = DetailsCoordinatingSpy()
        viewControllerSpy = DetailsDisplayingSpy()
        presenter = DetailsPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
    }

    override func tearDown() {
        coordinatorSpy = nil
        viewControllerSpy = nil
        presenter = nil
        super.tearDown()
    }

    func testPresentLayout_WhenWebsiteIsNotNil_ShouldDisplayNameAndWebsiteButton() {
        let exchange = ExchangeViewModel.mock()

        presenter.presentLayout(with: exchange)

        XCTAssertEqual(viewControllerSpy.messages, [
            .displayName(name: exchange.name, id: exchange.id),
            .displayWebsiteButton
        ])
    }

    func testPresentLayout_WhenWebsiteIsNil_ShouldDisplayName() {
        let exchange = ExchangeViewModel.mock(website: nil)

        presenter.presentLayout(with: exchange)

        XCTAssertEqual(viewControllerSpy.messages, [
            .displayName(name: exchange.name, id: exchange.id)
        ])
    }

    func testPresentWebsite_WhenURLIsValid_ShouldCallCoordinatorToOpenWebsite() throws {
        let exchange = ExchangeViewModel.mock()
        let url = try XCTUnwrap(URL(string: "https://test.com"))

        presenter.presentWebsite(urlString: exchange.website)

        XCTAssertEqual(coordinatorSpy.messages, [.openWebsite(url: url)])
    }

    func testPresentWebsite_WhenURLStringIsNil_ShouldReturnVoidFunction() {
        presenter.presentWebsite(urlString: nil)

        XCTAssertEqual(coordinatorSpy.messages, [])
    }
}
