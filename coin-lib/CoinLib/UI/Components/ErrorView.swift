//
//  ErrorView.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetryButton()
}

final class ErrorView: UIView {
    enum Layout {
        static let imageHeight: CGFloat = 150
        static let imageWidth: CGFloat = 200
        static let buttonHeight: CGFloat = 44
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Space.base03.rawValue
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Strings.Image.error)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleText: Text = {
        let text = Text(font: Font.boldTitle)
        text.value = Strings.Error.title
        return text
    }()

    private lazy var descriptionText: Text = {
        let text = Text(font: Font.boldBody, textAlignment: .center, textColor: .systemGray)
        text.value = Strings.Error.description
        text.numberOfLines = .zero
        return text
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Space.base01.rawValue
        button.backgroundColor = .systemYellow
        button.setTitle(Strings.Error.retry, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var delegate: ErrorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    required init?(coder: NSCoder) { nil }
}

// MARK: - ViewConfiguration
extension ErrorView: ViewConfiguration {
    func buildHierarchy() {
        addSubview(stackView)
        addSubview(button)

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleText)
        stackView.addArrangedSubview(descriptionText)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03.rawValue),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03.rawValue),

            imageView.heightAnchor.constraint(equalToConstant: Layout.imageHeight),
            imageView.widthAnchor.constraint(equalToConstant: Layout.imageWidth),

            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Space.base05.rawValue),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Space.base03.rawValue),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Space.base03.rawValue),
            button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight)
        ])
    }

    func configureViews() {
        backgroundColor = .systemBackground
    }
}

// MARK: - Private methods
private extension ErrorView {
    @objc
    func didTapButton() {
        delegate?.didTapRetryButton()
    }
}
