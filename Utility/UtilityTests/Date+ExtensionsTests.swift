//
//  Date+ExtensionsTests.swift
//  UtilityTests
//
//  Created by eren  on 31/10/2023.
//

import XCTest
@testable import Utility

final class Date_ExtensionsTests: XCTestCase {

    func testShowAsStandartFormat() {
        let flpDate = Date(flpServiceStyle: "2023-10-29T07:03:42Z")
        let standartFormat = flpDate.showAsStandartFormat()

        XCTAssertEqual(standartFormat, "2023-10-29 07:03:42")
    }
}
