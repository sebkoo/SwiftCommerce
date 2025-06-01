//
//  OrderHistoryService.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import Foundation

final class OrderHistoryService {
    static let shared = OrderHistoryService()
    private let key = "order_history"

    private init() {}

    func save(order: [Product]) {
        var history = loadHistory()
        history.append(order)
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func loadHistory() -> [[Product]] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let history = try? JSONDecoder().decode([[Product]].self, from: data)
        else { return [] }
        return history
    }

    func clearHistory() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
