//
//  CartManager.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

final class CartManager: ObservableObject {
    @Published private(set) var items: [Product] = [] {
        didSet { saveCart() }
    }

    private let cartKey = "saved_cart"

    init() { loadCart() }

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

    private func saveCart() {
        guard let encoded = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(encoded, forKey: cartKey)
    }

    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartKey),
              let decoded = try? JSONDecoder().decode([Product].self, from: data)
        else { return }
        self.items = decoded
    }
}
