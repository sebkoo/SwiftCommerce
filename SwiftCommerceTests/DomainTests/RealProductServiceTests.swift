//
//  RealProductServiceTests.swift
//  SwiftCommerceTests
//
//  Created by Ben Koo on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class RealProductServiceTests: XCTestCase {

    func testFetchProductsFromBundle() async throws {
        let service = RealProductService()
        let products = try await service.fetchProducts()

        XCTAssertEqual(products.count, 2)
        XCTAssertEqual(products.first?.name, "Swift Sneakers")
    }
}
