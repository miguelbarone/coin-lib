//
//  DetailsViewController.swift
//  CoinLib
//
//  Created by Miguel Barone on 13/09/24.
//

import Foundation
import UIKit

final class DetailsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
}

extension DetailsViewController: ViewConfiguration {
    func buildHierarchy() {
        
    }

    func setupConstraints() {
        
    }

    func configureViews() {
        view.backgroundColor = .systemBackground
    }
}
