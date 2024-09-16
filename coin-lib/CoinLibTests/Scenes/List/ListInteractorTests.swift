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
        case presentItems(exchangesModel: [ExchangeModel])
        case presentDetailsScreen(exchange: ExchangeViewModel)
        case presentErrorView
    }

    private(set) var messages = [Message]()

    func showLoading() {
        messages.append(.showLoading)
    }

    func hideLoading() {
        messages.append(.hideLoading)
    }

    func presentItems(_ exchangesModel: [ExchangeModel]) {
        messages.append(.presentItems(exchangesModel: exchangesModel))
    }

    func presentDetailsScreen(with exchange: ExchangeViewModel) {
        messages.append(.presentDetailsScreen(exchange: exchange))
    }

    func presentErrorView() {
        messages.append(.presentErrorView)
    }
}

final class ListServiceMock: ListServicing {
    var getExchangesResult: Result<[ExchangeModel], Error>?

    func getExchanges(completion: @escaping (Result<[ExchangeModel], Error>) -> Void) {
        guard let result = getExchangesResult else {
            XCTFail("getExchanges result not implemented")
            return
        }
        completion(result)
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

    func testFetchData_WhenResultIsSuccess_ShouldPresentItems() {
        let exchangeModels = [ExchangeModel.mock()]
        serviceMock.getExchangesResult = .success(exchangeModels)

        interactor.fetchData()

        XCTAssertEqual(presenterSpy.messages, [.showLoading, .hideLoading, .presentItems(exchangesModel: exchangeModels)])
    }

    func testFetchData_WhenResultIsFailure_ShouldPresentErrorView() {
        serviceMock.getExchangesResult = .failure(NSError(domain: "", code: 0, userInfo: nil))

        interactor.fetchData()

        XCTAssertEqual(presenterSpy.messages, [.showLoading, .hideLoading, .presentErrorView])
    }

    func testDidSelectRow_ShouldPresentDetailsScreen() {
        let exchangeViewModel = ExchangeViewModel.mock()

        interactor.didSelectRow(exchange: exchangeViewModel)

        XCTAssertEqual(presenterSpy.messages, [.presentDetailsScreen(exchange: exchangeViewModel)])
    }
}
