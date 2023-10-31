//
//  FlickrAppUITests.swift
//  FlickrAppUITests
//
//  Created by eren  on 31/10/2023.
//

import XCTest

final class FlickrAppUITests: XCTestCase {

    func testExample() throws {

        let app = XCUIApplication()
        app.launch()

        XCTAssert(app.staticTexts["yorkshire"].exists)

        XCTAssert(app.buttons["Search"].exists)

        app.buttons["Search"].tap()

        XCTAssert(app.staticTexts["Search by username. Example: HWSH"].exists)
        XCTAssert(app.staticTexts["Search by tags."].exists)

//        app.alerts["Info"].scrollViews.otherElements.buttons["Ok"].tap()
//
//        XCUIApplication().navigationBars["Uploads from Brian H Whittle"].buttons["Back"].tap()

        //        let cell = app.table.cells.element(boundBy:0)
        //        XCTAssertTrue(cell.exists)
        //        cell.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
