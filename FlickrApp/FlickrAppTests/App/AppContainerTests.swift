//
//  AppContainer.swift
//  FlickrAppTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest

@testable import FlickrApp

final class AppContainerTests: XCTestCase {

    func testAppContainerInit() {
        let appContainer = AppContainer()

        XCTAssertNotNil(appContainer.router)
        XCTAssertNotNil(appContainer.apiService)
    }
}
