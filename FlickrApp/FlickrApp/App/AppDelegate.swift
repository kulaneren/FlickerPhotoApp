//
//  AppDelegate.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appContainer.router.start()
        return true
    }
}

