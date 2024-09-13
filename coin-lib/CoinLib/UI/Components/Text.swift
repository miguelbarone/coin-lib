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

    var numberOfLines = 1 {
        didSet {
            body.numberOfLines = numberOfLines
        }
    }

    init(font: UIFont = Font.body, textAlignment: NSTextAlignment = .natural, textColor: UIColor? = nil) {
        body.font = font
        body.textAlignment = textAlignment
        body.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        buildLayout()

        if let textColor {
            body.textColor = textColor
        }
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
