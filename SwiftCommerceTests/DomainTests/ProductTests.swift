//
//  MockProductService.swift
//  SwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class ProductTests: XCTestCase {

    func testProductInitialization() {
        let uuid = UUID()
        let product = Product(id: uuid, name: "Test Product", price: 9.99, imageURL: URL(string: "https://example.com/image.jpg")!)

        XCTAssertEqual(product.id, uuid)
        XCTAssertEqual(product.name, "Test Product")
        XCTAssertEqual(product.price, 9.99)
        XCTAssertEqual(product.imageURL, URL(string: "https://example.com/image.jpg")!)
    }
}
