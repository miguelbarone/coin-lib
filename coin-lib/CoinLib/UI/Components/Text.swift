//
//  Text.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import UIKit

final class Text: UIView {
    private(set) var body = UILabel()

    var value = String() {
        didSet {
            body.text = value
        }
    }

    init(font: UIFont = Font.body, textAlignment: NSTextAlignment = .natural) {
        body.font = font
        body.textAlignment = textAlignment
        body.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        buildLayout()
    }

    required init?(coder: NSCoder) { nil }
}

extension Text: ViewConfiguration {
    func buildHierarchy() {
        addSubview(body)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: topAnchor),
            body.bottomAnchor.constraint(equalTo: bottomAnchor),
            body.leadingAnchor.constraint(equalTo: leadingAnchor),
            body.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configureViews() {
        body.textColor = traitCollection.userInterfaceStyle == .dark ? .white : .black
    }
}
