//
//  CartManagerTests.swift
//  SwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class CartManagerTests: XCTestCase {

    func testAddToCartIncreasesItemCount() async {
        let cart = CartManager()
        let product = Product(
            id: UUID(),
            name: "Test Cart Product",
            price: 9.99,
            imageURL: URL(string: "https://example.com/image.jpg")!
        )

        XCTAssertEqual(cart.totalItems, 0)
        cart.addToCart(product)
        XCTAssertEqual(cart.totalItems, 1)
        XCTAssertEqual(cart.items.first?.name, "Test Cart Product")
    }

    func testClearCartRemovesAllItems() async {
        let cart = CartManager()
        let product = Product(
            id: UUID(),
            name: "Another Product",
            price: 12.34,
            imageURL: URL(string: "https://example.com/another.jpg")!
        )
        
        cart.addToCart(product)
        cart.addToCart(product)
        XCTAssertEqual(cart.totalItems, 2)

        cart.clearCart()
        XCTAssertEqual(cart.totalItems, 0)
    }
}
