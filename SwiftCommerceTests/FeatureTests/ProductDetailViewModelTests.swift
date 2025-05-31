//
//  ProductDetailViewModelTests.swift
//  SwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class ProductDetailViewModelTests: XCTestCase {

    func testInitStoresProduct() {
        let product = Product(
            id: UUID(),
            name: "Test Detail Product",
            price: 99.99,
            imageURL: URL(string: "https://example.com/test.jpg")!
        )
        let cart = CartManager()

        let viewModel = ProductDetailViewModel(product: product, cart: cart)

        XCTAssertEqual(viewModel.product.name, "Test Detail Product")
        XCTAssertEqual(viewModel.product.price, 99.99)
    }
}
