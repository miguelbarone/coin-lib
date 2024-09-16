//
//  ListServiceTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

@testable import CoinLib
import XCTest

final class ListServiceTests: XCTestCase {
    var networkSpy: NetworkSpy!
    var service: ListService!

    override func setUp() {
        super.setUp()
        networkSpy = NetworkSpy()
        service = ListService(network: networkSpy)
    }

    override func tearDown() {
        networkSpy = nil
        service = nil
        super.tearDown()
    }

    func testGetExchanges_WhenResultIsSuccess_ShouldReturnExchanges() {
        let exchangeModels = [ExchangeModel.mock()]
        networkSpy.executeResult = .success(exchangeModels)

        var result: Result<[ExchangeModel], Error>?
        let expectation = XCTestExpectation(description: "Completion handler called")

        service.getExchanges { res in
            result = res
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch result {
        case .success(let exchanges):
            XCTAssertEqual(exchanges, exchangeModels)
        case .failure:
            XCTFail("Expected success, got failure")
        case .none:
            XCTFail("Completion handler not called")
        }
    }

    func testGetExchanges_WhenResultIsFailure_ShouldReceiveError() {
        let error = NSError(domain: "", code: 0, userInfo: nil)
        networkSpy.executeResult = .failure(error)

        var result: Result<[ExchangeModel], Error>?
        let expectation = XCTestExpectation(description: "Completion handler called")

        service.getExchanges { res in
            result = res
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)

        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let receivedError as NSError):
            XCTAssertEqual(receivedError, error)
        case .none:
            XCTFail("Completion handler not called")
        }
    }
}
