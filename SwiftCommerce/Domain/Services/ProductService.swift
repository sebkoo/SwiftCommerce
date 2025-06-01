//
//  ProductService.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

protocol ProductService {
    func fetchProducts() async throws -> [Product]
}

final class MockProductService: ProductService {
    func fetchProducts() async throws -> [Product] {
        return [
            Product(id: 1, name: "Mock Shoes", price: 49.99, imageURL: URL(string: "https://example.com/shoes.jpg")!),
            Product(id: 2, name: "Mock Shirt", price: 29.99, imageURL: URL(string: "https://example.com/shirt.jpg")!)
        ]
    }
}
