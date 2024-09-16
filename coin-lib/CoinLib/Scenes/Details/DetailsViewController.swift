//
//  DetailsViewController.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

protocol DetailsDisplaying: AnyObject {
    func displayName(_ name: String, id: String)
    func displayWebsiteButton()
}

final class DetailsViewController: UIViewController {
    fileprivate enum Layout {
        static let graphImageHeight: CGFloat = 180
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Space.base03.rawValue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Space.base00.rawValue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nameText = Text(font: Font.boldTitle)
    private lazy var idText = Text(font: Font.medium, textColor: .lightGray)

    private lazy var graphImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Strings.Image.fakeGraph)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var websiteButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Details.websiteButtonTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = Font.boldBody
        button.addTarget(self, action: #selector(didTapWebsiteButton), for: .touchUpInside)
        button.isHidden = true
        button.accessibilityIdentifier = "websiteButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var aboutTitleText: Text = {
        let text = Text(font: Font.medium)
        text.value = Strings.Details.aboutTitle
        return text
    }()

    private lazy var aboutText: Text = {
        let text = Text()
        text.value = Strings.Details.about
        return text
    }()

    private let interactor: DetailsInteracting

    init(interactor: DetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        interactor.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension DetailsViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(contentStackView)

        contentStackView.addArrangedSubview(nameStackView)
        contentStackView.addArrangedSubview(graphImage)
        contentStackView.addArrangedSubview(websiteButton)
        contentStackView.addArrangedSubview(aboutTitleText)
        contentStackView.addArrangedSubview(aboutText)

        nameStackView.addArrangedSubview(nameText)
        nameStackView.addArrangedSubview(idText)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.base03.rawValue),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.base04.rawValue),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.base03.rawValue),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.base03.rawValue),

            graphImage.heightAnchor.constraint(equalToConstant: Layout.graphImageHeight)
        ])
    }

    func configureViews() {
        title = Strings.Details.title
        view.backgroundColor = .systemBackground

        nameText.numberOfLines = .zero
        aboutText.numberOfLines = .zero

        idText.contentHuggingPriority(for: .horizontal)

        contentStackView.setCustomSpacing(Space.base01.rawValue, after: aboutTitleText)
    }
}

extension DetailsViewController: DetailsDisplaying {
    func displayName(_ name: String, id: String) {
        nameText.value = name
        idText.value = id
    }

    func displayWebsiteButton() {
        websiteButton.isHidden = false
    }
}

private extension DetailsViewController {
    @objc
    func didTapWebsiteButton() {
        interactor.openWebsite()
    }
}
