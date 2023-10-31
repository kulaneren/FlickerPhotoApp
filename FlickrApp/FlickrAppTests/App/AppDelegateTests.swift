//
//  AppDelegate.swift
//  FlickrAppTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest

@testable import FlickrApp

final class AppDelegateTests: XCTestCase {

    func testApplicationDidFinishLaunchingWithOptions() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let result = appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])

        XCTAssertTrue(result)
    }
}

