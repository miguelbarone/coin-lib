//
//  ViewConfiguration.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

protocol ViewConfiguration {
    func buildLayout()
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func buildLayout() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
