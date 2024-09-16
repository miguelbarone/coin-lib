//
//  RequestMock.swift
//  CoinLibTests
//
//  Created by Miguel Barone on 16/09/24.
//

import Foundation
@testable import CoinLib

struct RequestMock: Request {
    var method: HTTPMethod
    var endpoint: String
}
