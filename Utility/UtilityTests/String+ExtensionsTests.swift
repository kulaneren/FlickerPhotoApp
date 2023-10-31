//
//  String+ExtensionsTests.swift
//  UtilityTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest
@testable import Utility

final class String_ExtensionsTests: XCTestCase {

    func testRemovingHTMLOccurances() {
        let html = "<html><body>FlickrApp</body></html>"
        let modifiedStr = html.removingHTMLOccurances

        XCTAssertEqual(modifiedStr, "FlickrApp")
    }

    func testRemovingUnderscore() {
        let text = "Flickr_App"
        let modifiedStr = text.removingUnderscore

        XCTAssertEqual(modifiedStr, "Flickr App")

    }
}
