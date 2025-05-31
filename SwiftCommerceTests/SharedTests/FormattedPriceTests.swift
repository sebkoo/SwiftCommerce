//
//  FormattedPriceTests.swift
//  SwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import XCTest
@testable import SwiftCommerce

final class FormattedPriceTests: XCTestCase {
    func testCurrencyFormattingInCurrentLocale() {
        let formatted = FormattedPrice.shared.string(from: 1234.56)

        XCTAssertTrue(formatted.contains("1,234")
                   || formatted.contains("1.234")
                   || formatted.contains("$")
                   || formatted.contains("₩")
        )
    }
}
