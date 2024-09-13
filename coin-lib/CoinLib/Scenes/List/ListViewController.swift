//
//  ListViewController.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

final class ListViewController: UIViewController {
    private let interactor: ListInteracting

    init(interactor: ListInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchData()
    }
}
