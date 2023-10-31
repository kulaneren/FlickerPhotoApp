//
//  AppRouter.swift
//  FlickrAppTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest

@testable import FlickrApp

final class AppRouterTests: XCTestCase {

    var appRouter: AppRouter!

    override func setUpWithError() throws {
        appRouter = AppRouter()
    }

    override func tearDownWithError() throws {
        appRouter = nil
    }

    func testAppRouterInit() {
        XCTAssertNotNil(appRouter.window)
    }

    func testStart() {
        appRouter.start()

        guard let rootNavigationController = appRouter.window.rootViewController as? UINavigationController else {
            XCTFail("Window's rootViewController can't be nil")
            return
        }
        guard let topViewController = rootNavigationController.topViewController else {
            XCTFail("TopViewController can't be nil")
            return
        }
        XCTAssertTrue(topViewController.isKind(of: PhotoListViewController.self))
    }
}

