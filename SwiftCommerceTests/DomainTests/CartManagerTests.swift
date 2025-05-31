//
//  CartManagerTests.swift
//  SwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class CartManagerTests: XCTestCase {

    private let cartKey = "saved_cart"

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: cartKey)
    }

    func testAddToCartIncreasesItemCount() async {
        let cart = CartManager()
        let product = makeMockProduct(name: "Sneaker", price: 80)

        cart.addToCart(product)

        XCTAssertEqual(cart.totalItems, 1)
        XCTAssertEqual(cart.items.first?.name, "Sneaker")
    }

    func testRemoveFromCartReducesItemCount() async {
        let cart = CartManager()
        let product = makeMockProduct(name: "Sneaker", price: 80)
        cart.addToCart(product)

        cart.remove(atOffsets: IndexSet(integer: 0))
        XCTAssertEqual(cart.totalItems, 0)
    }

    func testClearCartRemovesAllItems() async {
        let cart = CartManager()
        cart.addToCart(makeMockProduct(name: "Snaker", price: 80))
        cart.addToCart(makeMockProduct(name: "Hat", price: 20))

        cart.clearCart()

        XCTAssertTrue(cart.items.isEmpty)
        XCTAssertEqual(cart.totalPrice, 0)
    }

    func testTotalPRiceReflectsSumOfItems() async {
        let cart = CartManager()
        cart.addToCart(makeMockProduct(name: "Sneaker", price: 80))
        cart.addToCart(makeMockProduct(name: "Hat", price: 20))

        XCTAssertEqual(cart.totalPrice, 100)
    }

    func testCartPersistsToUserDefaults() async {
        let product = makeMockProduct(name: "Backpack", price: 40)

        let cart = CartManager()
        cart.addToCart(product)

        let reloadedCart = CartManager()
        XCTAssertEqual(reloadedCart.totalItems, 1)
        XCTAssertEqual(reloadedCart.items.first?.name, "Backpack")
    }
}

extension CartManagerTests {    // Helpers
    private func makeMockProduct(name: String, price: Double) -> Product {
        Product(
            id: UUID(),
            name: name,
            price: price,
            imageURL: URL(string: "https://mock.com/\(UUID().uuidString)")!
        )
    }
}
