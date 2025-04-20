//
//  Environment.swift
//  CoinLib
//
//  Created by Miguel Barone on 19/04/25.
//

import Foundation

enum Environment {
    enum Keys {
        static let  baseURL = "BASE_URL"
        static let apiKey = "API_KEY"
    }

    private static let infoDict: [String: Any] = {
        guard let infoDict = Bundle.main.infoDictionary else {
            fatalError("Info.plist file not found")
        }

        return infoDict
    }()

    static let baseURL: String = {
        guard let baseURL = infoDict[Keys.baseURL] as? String else {
            fatalError("BASE_URL not found")
        }

        return baseURL
    }()

    static let apiKey: String = {
        guard let apiKey = infoDict[Keys.apiKey] as? String else {
            fatalError("API_KEY not found")
        }

        return apiKey
    }()
}
