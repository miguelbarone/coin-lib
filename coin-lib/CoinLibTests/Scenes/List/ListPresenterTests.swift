//
//  ListPresenterTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class ListDisplayingSpy: ListDisplaying {
    enum Message: Equatable {
        case showLoading
        case hideLoading
        case displayExchanges(exchanges: [ExchangeViewModel])
        case displayErrorView
    }

    private(set) var messages = [Message]()

    func showLoading() {
        messages.append(.showLoading)
    }

    func hideLoading() {
        messages.append(.hideLoading)
    }

    func displayExchanges(_ exchanges: [ExchangeViewModel]) {
        messages.append(.displayExchanges(exchanges: exchanges))
    }

    func displayErrorView() {
        messages.append(.displayErrorView)
    }
}

class ListCoordinatorSpy: ListCoordinating {
    enum Message: Equatable {
        case pushDetailsScreen(exchange: ExchangeViewModel)
    }

    private(set) var messages = [Message]()

    func pushDetailsScreen(with exchange: ExchangeViewModel) {
        messages.append(.pushDetailsScreen(exchange: exchange))
    }
}

class ListPresenterTests: XCTestCase {
    var coordinatorSpy: ListCoordinatorSpy!
    var viewControllerSpy: ListDisplayingSpy!
    var presenter: ListPresenter!

    override func setUp() {
        super.setUp()
        coordinatorSpy = ListCoordinatorSpy()
        viewControllerSpy = ListDisplayingSpy()
        presenter = ListPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
    }

    override func tearDown() {
        coordinatorSpy = nil
        viewControllerSpy = nil
        presenter = nil
        super.tearDown()
    }

    func testShowLoading_ShouldCallDisplayToShowLoading() {
        presenter.showLoading()

        XCTAssertEqual(viewControllerSpy.messages, [.showLoading])
    }

    func testHideLoading_ShouldCallDisplayToHideLoading() {
        presenter.hideLoading()

        XCTAssertEqual(viewControllerSpy.messages, [.hideLoading])
    }

    func testPresentItems_ShouldDisplayExchanges() {
        let exchangeModels = [ExchangeModel.mock()]

        presenter.presentItems(exchangeModels)

        XCTAssertEqual(viewControllerSpy.messages, [.displayExchanges(exchanges: [ExchangeViewModel.mock()])])
    }

    func testPresentDetailsScreen_ShouldCallCoordinatorToPushDetailsScreen() {
        let exchangeViewModel = ExchangeViewModel.mock()

        presenter.presentDetailsScreen(with: exchangeViewModel)

        XCTAssertEqual(coordinatorSpy.messages, [.pushDetailsScreen(exchange: exchangeViewModel)])
    }

    func testPresentErrorView_ShouldDisplayErrorView() {
        presenter.presentErrorView()
        XCTAssertEqual(viewControllerSpy.messages, [.displayErrorView])
    }
}
