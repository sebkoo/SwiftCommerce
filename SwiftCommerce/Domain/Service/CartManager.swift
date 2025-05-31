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

    func remove(atOffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    var totalItems: Int {
        items.count
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
}
