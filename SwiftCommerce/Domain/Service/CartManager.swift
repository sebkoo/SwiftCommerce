//
//  CartManager.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

final class CartManager: ObservableObject {
    @Published private(set) var items: [Product] = []

    func addToCart(_ product: Product) {
        items.append(product)
    }

    func clearCart() {
        items.removeAll()
    }

    var totalItems: Int {
        items.count
    }
}
