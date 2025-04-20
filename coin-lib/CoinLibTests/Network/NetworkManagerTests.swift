//
//  NetworkManagerTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 14/09/24.
//

import Foundation
import XCTest
@testable import CoinLib

final class URLSessionSpy: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var sessionSpy: URLSessionSpy!

    override func setUp() {
        super.setUp()
        sessionSpy = URLSessionSpy()
        networkManager = NetworkManager(urlSession: sessionSpy)
    }

    override func tearDown() {
        networkManager = nil
        sessionSpy = nil
        super.tearDown()
    }

    func testFetch_WhenDataAndResponseIsValid_ShouldDecodeDataAndCompareValues() async throws {
        let model = CodableModel(id: 1, name: "Test")
        let data = try JSONEncoder().encode(model)
        let request = RequestMock(method: .get, endpoint: "/valid")
        let url = try XCTUnwrap(URL(string: "/valid"))

        sessionSpy.data = data
        sessionSpy.response = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)

        let result: CodableModel = try await networkManager.fetch(request: request)

        XCTAssertEqual(result, model)
    }

    func testFetch_WhenResponseIsNil_ShouldThrowInvalidResponseError() async throws {
        let request = RequestMock(method: .get, endpoint: "/valid")

        sessionSpy.response = nil

        do {
            let _: CodableModel = try await networkManager.fetch(request: request)
            XCTFail("Expected to throw invalidResponse error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .invalidResponse)
        } catch {
            XCTFail("Expected to throw invalidResponse error")
        }
    }

    func testFetch_WhenIsErrorStatusCode_ShouldThrowRequestErrorWithStatusCode() async throws {
        let request = RequestMock(method: .get, endpoint: "/valid")
        let url = try XCTUnwrap(URL(string: "/valid"))
        
        sessionSpy.response = HTTPURLResponse(
            url: url,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        do {
            let _: CodableModel = try await networkManager.fetch(request: request)
            XCTFail("Expected to throw requestError")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .requestError(description: "Unexpected error: 500"))
        } catch {
            XCTFail("Expected to throw requestError")
        }
    }

    func testFetch_WhenDataIsInvalid_ShouldReturnDecodingError() async throws {
        let request = RequestMock(method: .get, endpoint: "/valid")
        let url = try XCTUnwrap(URL(string: "/valid"))

        sessionSpy.data = Data("invalid".utf8)
        sessionSpy.response = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)

        do {
            let _: CodableModel = try await networkManager.fetch(request: request)
            XCTFail("Expected to throw decodingError")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .decodingError(description: "The data couldn’t be read because it isn’t in the correct format."))
        } catch {
            XCTFail("Expected to throw decodingError")
        }
    }
}
