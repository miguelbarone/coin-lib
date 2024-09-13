//
//  AppDelegate.swift
//  CoinLib
//
//  Created by Miguel Barone on 11/09/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: ListFactory.make())

        let tintColor: UIColor = navigationController.traitCollection.userInterfaceStyle == .dark ? .white : .black
        navigationController.navigationBar.tintColor = tintColor
        navigationController.navigationBar.prefersLargeTitles = true

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}
