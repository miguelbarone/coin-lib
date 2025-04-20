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

    func testGetExchanges_WhenResultIsSuccess_ShouldReturnExchanges() async throws {
        let exchangeResponse = [ExchangeResponse.mock()]
        networkSpy.setResult(exchangeResponse)

        let result = try await service.getExchanges()

        XCTAssertEqual(result, exchangeResponse)
    }

    func testGetExchanges_WhenResultIsFailure_ShouldReceiveError() async throws {
        networkSpy.setError(NetworkError.invalidURL)

        do {
            let _ = try await service.getExchanges()
        } catch {
            XCTAssertEqual(try XCTUnwrap(error as? NetworkError), NetworkError.invalidURL)
            XCTAssertEqual(networkSpy.fetchResult, nil)
        }
    }
}
