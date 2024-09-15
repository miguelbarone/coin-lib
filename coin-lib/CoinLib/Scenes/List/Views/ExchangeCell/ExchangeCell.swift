//
//  ExchangeCell.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

final class ExchangeCell: UITableViewCell {
    fileprivate enum Layout {
        static let valueTextMinWidth: CGFloat = 53
    }

    private lazy var hashText = Text()
    private lazy var nameText = Text(font: Font.boldBody)
    private lazy var idText = Text(textColor: .systemGray)
    private lazy var valueText = Text()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Space.base02.rawValue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }

    required init?(coder: NSCoder) { nil }

    func setup(with model: ExchangeViewModel) {
        hashText.value = model.hash
        nameText.value = model.name
        idText.value = model.id
        valueText.value = model.value
    }
}

extension ExchangeCell: ViewConfiguration {
    func buildHierarchy() {
        contentView.addSubview(infoStackView)
        contentView.addSubview(valueText)

        infoStackView.addArrangedSubview(hashText)
        infoStackView.addArrangedSubview(nameText)
        infoStackView.addArrangedSubview(idText)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.base02.rawValue),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.base02.rawValue),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.base01.rawValue),

            valueText.centerYAnchor.constraint(equalTo: infoStackView.centerYAnchor),
            valueText.leadingAnchor.constraint(greaterThanOrEqualTo: infoStackView.trailingAnchor, constant: Space.base01.rawValue),
            valueText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.base01.rawValue),
            valueText.widthAnchor.constraint(greaterThanOrEqualToConstant: Layout.valueTextMinWidth)
        ])
    }

    func configureViews() {
        nameText.numberOfLines = .zero
    }
}
