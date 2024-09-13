//
//  ListViewController.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

protocol ListDisplaying: AnyObject {
    func showLoading()
    func hideLoading()
    func displayExchanges(_ exchanges: [ExchangeViewModel])
    func displayErrorView()
}

final class ListViewController: UIViewController {
    fileprivate enum Layout {
        static let cellHeight: CGFloat = 70
    }

    private lazy var loadingView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = traitCollection.userInterfaceStyle == .dark ? .white : .black
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Layout.cellHeight
        tableView.register(ExchangeCell.self, forCellReuseIdentifier: Strings.Identifier.exchangeCell)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.delegate = self
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()

    private let interactor: ListInteracting

    private var exchanges = [ExchangeViewModel]()

    init(interactor: ListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        interactor.fetchData()
    }
}

// MARK: - ViewConfiguration
extension ListViewController: ViewConfiguration {
    func buildHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Space.base04.rawValue),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func configureViews() {
        title = Strings.Exchange.title
        view.backgroundColor = .systemBackground
    }
}

// MARK: - ListDisplaying
extension ListViewController: ListDisplaying {
    func showLoading() {
        loadingView.startAnimating()
    }

    func hideLoading() {
        loadingView.stopAnimating()
    }

    func displayExchanges(_ exchanges: [ExchangeViewModel]) {
        self.exchanges = exchanges

        tableView.reloadData()
        tableView.isScrollEnabled = true
    }

    func displayErrorView() {
        view.addSubview(errorView)

        NSLayoutConstraint.activate([
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exchanges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = Strings.Identifier.exchangeCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ExchangeCell else {
            return UITableViewCell()
        }
        cell.setup(with: exchanges[indexPath.row])
        return cell
    }
}

extension ListViewController: ErrorViewDelegate {
    func didTapRetryButton() {
        errorView.removeFromSuperview()

        interactor.fetchData()
    }
}
