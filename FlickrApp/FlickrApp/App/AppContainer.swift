//
//  AppContainer.swift
//  FlickrApp
//
//  Created by eren  on 31/10/2023.
//

import Foundation
import FlickrAPI

let appContainer = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let apiService = FLPService()
}
