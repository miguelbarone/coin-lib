//
//  ListInteractorTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class ListPresentingSpy: ListPresenting {
    enum Message: Equatable {
        case showLoading
        case hideLoading
        case presentItems(exchangesModel: [ExchangeResponse])
        case presentDetailsScreen(exchange: ExchangeModel)
        case presentErrorView
    }

    private(set) var messages = [Message]()

    func showLoading() {
        messages.append(.showLoading)
    }

    func hideLoading() {
        messages.append(.hideLoading)
    }

    func presentItems(_ exchangesModel: [ExchangeResponse]) {
        messages.append(.presentItems(exchangesModel: exchangesModel))
    }

    func presentDetailsScreen(with exchange: ExchangeModel) {
        messages.append(.presentDetailsScreen(exchange: exchange))
    }

    func presentErrorView() {
        messages.append(.presentErrorView)
    }
}

final class ListServiceMock: ListServicing {
    var getExchangesResult: Result<[ExchangeResponse], Error>?
    var exchanges: [ExchangeResponse]?
    var error: NetworkError?

    func getExchanges() async throws -> [ExchangeResponse] {
        if let error {
            throw error
        }

        if let exchanges {
            return exchanges
        }

        throw NetworkError.noData
    }
}

final class ListInteractorTests: XCTestCase {
    var presenterSpy: ListPresentingSpy!
    var serviceMock: ListServiceMock!
    var interactor: ListInteractor!

    override func setUp() {
        super.setUp()
        presenterSpy = ListPresentingSpy()
        serviceMock = ListServiceMock()
        interactor = ListInteractor(presenter: presenterSpy, service: serviceMock)
    }

    override func tearDown() {
        presenterSpy = nil
        serviceMock = nil
        interactor = nil
        super.tearDown()
    }

    func testFetchData_WhenResultIsSuccess_ShouldPresentItems() async {
        let exchangeModels = [ExchangeResponse.mock()]
        let expectation = XCTestExpectation(description: "fetchData completes")

        serviceMock.exchanges = exchangeModels

        Task {
            interactor.fetchData()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)

        XCTAssertEqual(presenterSpy.messages, [.showLoading, .presentItems(exchangesModel: exchangeModels), .hideLoading])
    }

    func testFetchData_WhenResultIsFailure_ShouldPresentErrorView() async {
        let expectation = XCTestExpectation(description: "fetchData completes")
        serviceMock.error = NetworkError.invalidURL

        Task {
            interactor.fetchData()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)

        XCTAssertEqual(presenterSpy.messages, [.showLoading, .presentErrorView, .hideLoading])
    }

    func testDidSelectRow_ShouldPresentDetailsScreen() {
        let exchangeViewModel = ExchangeModel.mock()

        interactor.didSelectRow(exchange: exchangeViewModel)

        XCTAssertEqual(presenterSpy.messages, [.presentDetailsScreen(exchange: exchangeViewModel)])
    }
}
