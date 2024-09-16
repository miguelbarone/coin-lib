//
//  NetworkManagerTests.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 14/09/24.
//

import Foundation
import XCTest
@testable import CoinLib

final class URLSessionSpy: URLSession {
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    private let dataTask = URLSessionDataTaskSpy()

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTask.completion = { [weak self] in
            guard let self else { return }
            completionHandler(data, response, error)
        }
        return dataTask
    }
}

final class URLSessionDataTaskSpy: URLSessionDataTask {
    var completion: () -> Void = {}

    override func resume() {
        completion()
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

    func testExecute_WhenDataAndResponseIsValid_ShouldDecodeDataAndCompareValues() throws {
        let data = DecodableModel.json.data(using: .utf8)
        let request = RequestMock(method: .get, endpoint: "/valid")
        let url = try XCTUnwrap(URL(string: "/valid"))

        sessionSpy.data = data
        sessionSpy.response = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)

        networkManager.execute(with: request) { (result: Result<DecodableModel, Error>) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model.id, 1)
                XCTAssertEqual(model.name, "Test")
            case .failure:
                XCTFail("Expected success, got failure")
            }
        }
    }

    func testExecute_WhenUrlIsInvalid_ShouldThrowInvalidURLNetworkError() {
        let request = RequestMock(method: .get, endpoint: "")

        networkManager.execute(with: request) { (result: Result<DecodableModel, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, .invalidURL)
            }
        }
    }

    func testExecute_WhenStatusCodeIsFromAnError_ShouldThrowInvalidResponseNetworkError() throws {
        let request = RequestMock(method: .get, endpoint: "/valid")
        let url = try XCTUnwrap(URL(string: "/valid"))

        sessionSpy.data = Data()
        sessionSpy.response = HTTPURLResponse(url: url,
                                              statusCode: 500,
                                              httpVersion: nil,
                                              headerFields: nil)

        networkManager.execute(with: request) { (result: Result<DecodableModel, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, .invalidResponse)
            }
        }
    }

    func testExecute_WhenDataIsInvalid_ShouldThrowNoDataNetworkError() throws {
        let request = RequestMock(method: .get, endpoint: "/valid")
        let url = try XCTUnwrap(URL(string: "/valid"))

        sessionSpy.response = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)

        networkManager.execute(with: request) { (result: Result<DecodableModel, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, .noData)
            }
        }
    }

    func testExecute_WhenErrorInSessionIsNotNil_ShouldThrowRequesErrorWithCustomizedMessage() {
        let request = RequestMock(method: .get, endpoint: "/valid")

        sessionSpy.error = NSError(domain: "TestError", code: 1, userInfo: nil)

        networkManager.execute(with: request) { (result: Result<DecodableModel, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, .requestError(description: "The operation couldn’t be completed. (TestError error 1.)"))
            }
        }
    }
}
