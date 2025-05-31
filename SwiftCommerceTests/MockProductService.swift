//
//  MockProductService.swift
//  SwiftCommerceTests
//
//  Created by Ben Koo on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class MockProductService: XCTestCase {
    func fetchProducts() async throws -> [Product] {
        return [
            Product(id: UUID(), name: "Test Product", price: 9.99)
        ]
    }
}
