//
//  CartManager.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

final class CartManager: ObservableObject {
    @Published private(set) var items: [Product] = []
    private let cartKey = "saved_cart"
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadCart()
    }

    func addToCart(_ product: Product) {
        items.append(product)
        saveCart()
    }

    func clearCart() {
        items.removeAll()
        saveCart()
    }

    func remove(atOffsets offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveCart()
    }

    var totalItems: Int {
        items.count
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }

    private func saveCart() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(items) {
            userDefaults.set(data, forKey: cartKey)
        }
    }

    private func loadCart() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let savedItems = try? decoder.decode([Product].self, from: data) {
            items = savedItems
        }
    }
}
