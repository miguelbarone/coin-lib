//
//  Strings.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

enum Strings {
    static let usdCode = "USD"

    enum Identifier {
        static let exchangeCell = "ExchangeCell"
    }

    enum Image {
        static let error = "error-image"
    }

    enum Exchange {
        static let title = "Exchanges"
        static let defaultName = "Exchange"
    }

    enum Error {
        static let title = "Algo deu errado!"
        static let description = "Não conseguimos carregar as informações, tente novamente mais tarde."
        static let retry = "Tentar novamente"
    }
}
