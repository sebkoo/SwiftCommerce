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

    func testRemoveItemAtIndex() async {
        let cart = CartManager()
        let product1 = Product(id: UUID(), name: "Item 1", price: 5,  imageURL: URL(string: "https://a.com")!)
        let product2 = Product(id: UUID(), name: "Item 2", price: 10, imageURL: URL(string: "https://b.com")!)

        cart.addToCart(product1)
        cart.addToCart(product2)
        XCTAssertEqual(cart.totalItems, 2)

        cart.remove(atOffsets: IndexSet(integer: 0))
        XCTAssertEqual(cart.totalItems, 1)
        XCTAssertEqual(cart.items.first?.name, "Item 2")
    }

    func testTotalPriceReflectsAllItems() async {
        let cart = CartManager()
        let product1 = Product(id: UUID(), name: "Shoe", price: 50, imageURL: URL(string: "https://1.com")!)
        let product2 = Product(id: UUID(), name: "Hat",  price: 25, imageURL: URL(string: "https://2.com")!)

        cart.addToCart(product1)
        cart.addToCart(product2)

        XCTAssertEqual(cart.totalPrice, 75)
    }
}
