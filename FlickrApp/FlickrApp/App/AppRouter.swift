//
//  AppRouter.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

final class AppRouter {

    let window: UIWindow

    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        showPhotoList()
    }

    private func showPhotoList() {
        let viewController = PhotoListBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
